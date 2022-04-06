class ConversationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(conversation)
    ActionCable.server.broadcast "debate_channel_#{conversation.debate_id}", conversation: render_conversation(conversation)
  end

  private

  def render_conversation(conversation)
    ApplicationController.renderer.render(partial: 'debates/conversation', locals: { conversation: conversation })
  end
end
