# frozen_string_literal: true

class DebateComponent < ViewComponent::Base
  def initialize(debate:)
    @debate = debate
  end

end
