class Debate < ApplicationRecord
  belongs_to :created_user, class_name: "User"
  belongs_to :joined_user, class_name: "User"
end
