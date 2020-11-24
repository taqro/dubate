class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  # before_action :opener?, only: [:show]
  # before_action :opponent?, only: [:show]
  # before_action :opponent_exist?, only: [:index]
  helper_method :opener?, :opponent?, :opponent_nil?

  def index
    @rooms = Room.all.order(:id)
  end
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @opener = User.find(@room.user_id)

    if @room.opponent_id.nil? and (current_user.id != @room.user_id)
      @room.opponent_id = current_user.id
      @room.save!
    end
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

  # 議題作成者かどうか
  def opener?
    @room = Room.find(params[:id])
    current_user.id == @room.user_id
  end

  # opponentかどうか
  def opponent?
    @room = Room.find(params[:id])
    current_user.id == @room.opponent_id
  end

  #opponentが空かどうか 使うかわからん
  def opponent_nil?
    @room = Room.find(params[:id])
    @room.opponent_id.nil?
  end

end
