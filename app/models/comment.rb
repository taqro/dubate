class Comment < ApplicationRecord
  belongs_to :User, optional: true
  belongs_to :Debate, optional: true

  validates :user_id, presence: true
  validates :debate_id, presence: true
  validates :content, presence: true
end
