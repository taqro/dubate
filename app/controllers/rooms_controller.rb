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
    @room = Room.new(room_params)
    @room.save!
    redirect_to rooms_url, notice: "Room「#{@room.name}を作成しました。」"
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
