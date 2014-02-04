class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :phones, foreign_key: 'userid', dependent: :destroy
  has_many :computers, foreign_key: 'userid', dependent: :destroy

  validates :twitter, format: {with: /\A[A-Za-z0-9_]{0,15}\z/, message: 'must be a twitter handle'}

  def twitter=(handle)
    write_attribute :twitter, handle.gsub(/\A@/,'')
  end
end
