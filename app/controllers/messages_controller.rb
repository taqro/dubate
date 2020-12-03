class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    @message.user_id = current_user.id
    @message.save!

    ActionCable.server.broadcast 'room_channel', message: @message.template

  end

  private

  def message_params
    params.permit(:content, :room_id)
  end
end
