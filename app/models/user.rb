require 'digest/md5'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :computers, foreign_key: 'userid', dependent: :destroy

  validates :twitter, format: {with: /\A[A-Za-z0-9_]{1,15}\z/, message: 'must be a twitter handle'}, allow_blank: true
  validates :url, format: {with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: 'must be a valid http(s) URL'}, allow_blank: true
  validates :name, presence: true

  def email_md5
    Digest::MD5.hexdigest email
  end

  def twitter=(handle)
    write_attribute :twitter, handle.gsub(/\A@/,'') if handle
  end
end
