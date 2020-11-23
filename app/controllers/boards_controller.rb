class BoardsController < ApplicationController
  def show
    @board = Board.find_by(room_id: params[:room_id])
    @posts = @board.posts
  end

  def create
    @room = Room.find(params[:room_id])
    if Board.find_by(room_id: params[:room_id])
      @board = Board.find_by(room_id: params[:room_id])
    else
      @board = @room.build_board(user_id: current_user.id)
      @board.save
    end
    redirect_to room_boards_path(@room, @board)
  end
end
