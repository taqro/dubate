class Debate < ApplicationRecord
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :created_user, class_name: "User"
  belongs_to :joined_user, class_name: "User"
end
