class WinOrLose < ApplicationRecord
  belongs_to :Debate, optional: true
end
