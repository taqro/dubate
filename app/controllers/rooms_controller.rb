class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :destroy]
  before_action :correct_user, only: :destroy
  helper_method :opener?, :opponent?, :opponent_nil?


  def index
    @q = Room.all.ransack(params[:q])
    @rooms = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @opener = User.find(@room.user_id)

    if @room.opponent_id.nil? && current_user.id != @room.user_id
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
    redirect_to rooms_path, notice: "Room「#{@room.name}を削除しました。」"
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

  # opponentが空かどうか 使うかわからん
  def opponent_nil?
    @room = Room.find(params[:id])
    @room.opponent_id.nil?
  end

  # 勝者を定義、つまり@room.board.user_idにidが入っている方が負け
  def winner
    @room = Room.find(params[:id])
    @winner_id = @room.board.user_id == @room.opponent_id ? @room.user_id : @room.opponent_id
  end

  # def winnername
  #   @room = Room.find(params[:id])
  #   @winner_id = @room.board.user_id == @room.opponent_id ? @room.user_id : @room.opponent_id
  #   @winner = @user.find(@winner_id)
  # end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def correct_user
    @room = current_user.rooms.find_by(id: params[:id])
    redirect_to root_url if @room.nil?
  end

end
