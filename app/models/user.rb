class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :phones, foreign_key: 'userid', dependent: :destroy
  has_many :computers, foreign_key: 'userid', dependent: :destroy
end
