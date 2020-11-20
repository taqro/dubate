class RoomsController < ApplicationController

  def index
    @rooms = Room.all.order(:id)
  end
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    @room.save!
    redirect_to room_path(@room), notice: "Room「#{@room.name}を作成しました。」"
  end

  def delete
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
