class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_one :board, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
end
