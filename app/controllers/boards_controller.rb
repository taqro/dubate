class BoardsController < ApplicationController
  def show

  end

  def create
    @room = Room.find(params[:room_id])
    @board = @room.build_board(user_id: current_user.id)
    @board.save
    redirect_to room_boards_path(@room, @board)
  end
end
