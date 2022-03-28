class Vote < ApplicationRecord
  belongs_to :debate
  belongs_to :voting, class_name: 'User', optional: true
  belongs_to :voted, class_name: 'User', optional: true

  #デフォルト値設定
  attribute :status, :string, default: 'before_vote'
end
