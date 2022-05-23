# frozen_string_literal: true

class ConversationComponent < ViewComponent::Base
  def initialize(conversation:)
    @conversation = conversation
  end

end
