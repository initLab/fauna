require 'digest/md5'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  rolify

  has_many :network_devices, foreign_key: :owner_id, dependent: :destroy
  has_many :phone_numbers, foreign_key: :owner_id, dependent: :destroy

  validates :username, uniqueness: {case_sensitive: false}, format: {with: /\A[a-z0-9_\-]+\z/i}, presence: true
  validates :twitter, format: {with: /\A[A-Za-z0-9_]{1,15}\z/}, allow_blank: true
  validates :url, format: {with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix}, allow_blank: true
  validates :name, presence: true
  validates :github, format: {with: /\A[a-z][a-z-]{,38}\z/i}, allow_blank: true
  validates :jabber, format: {with: /\A[^@]+@[^@]+\z/}, allow_blank: true
  validates :gpg_fingerprint, format: {with: /\A[0-9a-f]{4}( ?)([0-9a-f]{4}\1){4}\1{0,2}([0-9a-f]{4}\1){4}[0-9a-f]{4}\z/i}, allow_blank: true

  accepts_nested_attributes_for :phone_numbers, update_only: true, allow_destroy: true, reject_if: :all_blank

  attr_accessor :login
  after_validation :normalize_gpg_fingerprint

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup

    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    end
  end

  def email_md5
    Digest::MD5.hexdigest email
  end

  def twitter=(handle)
    write_attribute :twitter, handle.gsub(/\A@/,'') if handle
  end

  def picture(size = 128)
    Gravatar.new(email).image_url ssl: true, s: size, d: 'retro'
  end

  private

  def normalize_gpg_fingerprint
    self.gpg_fingerprint = gpg_fingerprint.gsub(' ', '').upcase.gsub(/([0-9a-f]{4})/i, '\1 ').strip if self.gpg_fingerprint.present?
  end
end
