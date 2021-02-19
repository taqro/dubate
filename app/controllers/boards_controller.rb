class BoardsController < ApplicationController
  def show
    @board = Board.find_by(room_id: params[:room_id])
    @posts = @board.posts
  end

  def create
    # boardを作成された時点で勝敗が決まる（どちらかがサレンダーしたとき）
    @room = Room.find(params[:room_id])
    @board = @room.build_board(user_id: current_user.id)
    if @board.user_id == @room.user_id
      @board.loser = @room.user_id
      @board.winner = @room.opponent_id

      @room.loser = @room.user_id
      @room.winner = @room.opponent_id
    else
      @board.loser = @room.opponent_id
      @board.winner = @room.user_id

      @room.loser = @room.opponent_id
      @room.winner = @room.user_id
    end
    @board.save
    @room.save
    flash[:success] = "Boardを作成しました"
    redirect_to room_boards_path(@room, @board)
  end
end
