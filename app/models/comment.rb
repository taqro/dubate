class Comment < ApplicationRecord
  belongs_to :User, optional: true
  belongs_to :Debate, optional: true
end
