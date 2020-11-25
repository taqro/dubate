class Post < ApplicationRecord
  belongs_to :user
  belongs_to :board
  validates :content, presence: true
  after_create_commit { PostBroadcastJob.perform_later self }
end
