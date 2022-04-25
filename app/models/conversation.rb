class Conversation < ApplicationRecord
  belongs_to :User, optional: true
  belongs_to :Debate, optional: true

  after_create_commit { ConversationBroadcastJob.perform_later self }

  validates :user_id, presence: true
  validates :debate_id, presence: true
  validates :content, presence: true
end
