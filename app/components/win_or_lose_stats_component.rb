# frozen_string_literal: true

class WinOrLoseStatsComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

end
