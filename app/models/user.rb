require 'digest/md5'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  has_many :network_devices, foreign_key: :owner_id, dependent: :destroy

  validates :username, uniqueness: {case_sensitive: false}, format: {with: /\A[a-z0-9_\-]+\z/i}, presence: true
  validates :twitter, format: {with: /\A[A-Za-z0-9_]{1,15}\z/}, allow_blank: true
  validates :url, format: {with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix}, allow_blank: true
  validates :name, presence: true

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup

    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      nil
    end
  end

  def email_md5
    Digest::MD5.hexdigest email
  end

  def twitter=(handle)
    write_attribute :twitter, handle.gsub(/\A@/,'') if handle
  end
end
