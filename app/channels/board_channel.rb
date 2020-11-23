class BoardChannel < ApplicationCable::Channel
  def subscribed
    stream_from "board_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Post.create! content: data['post'], user_id: current_user.id, board_id: params['board']
  end
end
