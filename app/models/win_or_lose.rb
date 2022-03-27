class WinOrLose < ApplicationRecord
  belongs_to :Debate, optional: true
  belongs_to :winner, class_name: 'User'
  belongs_to :loser, class_name: 'User'
end
