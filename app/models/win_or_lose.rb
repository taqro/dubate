class WinOrLose < ApplicationRecord
  belongs_to :Debate, optional: true
  belongs_to :winner, class_name: 'User'
  belongs_to :loser, class_name: 'User'

  validates :debate_id, presence: true, uniqueness: true
  validates :winner_id, presence: true
  validates :loser_id, presence: true
end
