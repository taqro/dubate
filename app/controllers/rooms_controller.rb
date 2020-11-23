class RoomsController < ApplicationController

  before_action :correct_user, only: :destroy

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
    flash[:success] = "Room.created!"
    redirect_to room_path(@room), notice: "Room「#{@room.name}を作成しました。」"
  end

  def destroy
    @room.destroy
    flash[:success] = "Room.deleted"
    redirect_to rooms_path
  end



  private

  def room_params
    params.require(:room).permit(:name)
  end

  def correct_user
    @room = current_user.rooms.find_by(id: params[:id])
    redirect_to root_url if @room.nil?
  end

end
