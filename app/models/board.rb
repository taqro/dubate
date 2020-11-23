class Board < ApplicationRecord
  has_many :posts, dependent: :destroy
  belongs_to :room
end
