class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :username, presence: true, length: { maximum: 50 }
  validates :profile, length: { maximum: 200 }
end
