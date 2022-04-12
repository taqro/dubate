class Debate < ApplicationRecord
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :Conversations, dependent: :destroy
  has_many :Comments, dependent: :destroy
  has_one :WinOrLose, dependent: :destroy
  has_one :Vote, dependent: :destroy
  belongs_to :created_user, class_name: "User"
  belongs_to :joined_user, class_name: "User", optional: true

  #scope
  scope :recent, -> {order(created_at: :desc)}

  #デフォルト値設定
  attribute :wanted, :boolean, default: true
  attribute :status, :string, default: 'before_vote'
end
