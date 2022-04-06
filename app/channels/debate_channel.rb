class DebateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "debate_channel_#{params['debate_id']}"
    # debate = Debate.find(params['debate_id'])
    # stream_for debate
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    current_user.Conversations.create!(content: data['conversation'], debate_id: params['debate_id'])
    # ActionCable.server.broadcast('debate_channel_#{conversation.debate_id}', {conversation: data['conversation']})
  end
end
