class Vote < ApplicationRecord
  belongs_to :debate
  belongs_to :voting, class_name: 'User', optional: true
  belongs_to :voted, class_name: 'User', optional: true
end
