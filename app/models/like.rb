class Like < ApplicationRecord
  belongs_to :user
  belongs_to :debate

  validates :debate_id, presence: true, uniqueness: true
  validates :user_id, presence: true

end
