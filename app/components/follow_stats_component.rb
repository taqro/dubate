# frozen_string_literal: true

class FollowStatsComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

end
