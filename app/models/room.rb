class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_one :board
  belongs_to :user
end
