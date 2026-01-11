require 'digest/md5'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
    :recoverable, :rememberable, :trackable, :validatable, :doorkeeper,
    authentication_keys: [:login]

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :network_devices, foreign_key: :owner_id, dependent: :destroy
  has_many :phone_numbers, foreign_key: :owner_id, dependent: :destroy
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner

  validates :username, uniqueness: {case_sensitive: false}, presence: true
  validates :twitter, format: {with: /\A[A-Za-z0-9_]{1,15}\z/}, allow_blank: true
  validates :url, format: {with: /\A(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z-]{2,63}(:[0-9]{1,5})?(\/.*)?\z/ix}, allow_blank: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :github, format: {with: /\A[a-z0-9][a-z0-9-]{,38}\z/i}, allow_blank: true
  validates :jabber, format: {with: /\A[^@]+@[^@]+\z/}, allow_blank: true
  validates :pin, numericality: true, length: {minimum: 6}, allow_blank: true, confirmation: true
  validates :locale, presence: true, inclusion: {in: I18n.available_locales.map(&:to_s)}
  accepts_nested_attributes_for :phone_numbers, update_only: true, allow_destroy: true, reject_if: :all_blank

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup

    if (login = conditions.delete(:login))
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', {value: login.downcase.strip}]).first
    end
  end

  def has_role?(role)
    self.roles.exists?(name: role)
  end

  def add_role(role_name)
    role = Role.find_by(name: role_name)

    self.user_roles.find_or_create_by(role_id: role.id, end_time: nil)
    self.roles.reload
  end

  def remove_role(role_name)
    role = Role.find_by(name: role_name)

    self.user_roles.find_by(role_id: role.id).update(end_time: Time.current)
    self.roles.reload
  end

  def email_md5
    Digest::MD5.hexdigest email
  end

  def name
    [first_name, last_name].compact.join(' ').strip
  end

  def twitter=(handle)
    write_attribute :twitter, handle.gsub(/\A@/, '') if handle
  end

  def picture(size = 128)
    Gravatar.new(email).image_url ssl: true, s: size, d: 'retro'
  end

  def pin=(pin)
    if pin.present?
      @pin = pin
      self.encrypted_pin = BCrypt::Password.create pin
    end
  end

  attr_reader :pin

  def to_s
    "User(id: #{id}, email: #{email}, name: #{name})"
  end
end
