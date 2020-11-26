class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :debating_number


  def show
    @user = User.find(params[:id]) ? User.find(params[:id]) : current_user
    @rooms = @user.rooms.order(:id)
    @lose_number = @user.boards.count
    @win_number = match_number - @lose_number - debating_number
    @matched_number = match_number - debating_number #総対戦数
  end

  # 議論中のRoom数
  def debating_number
    @debating_number = 0
    participated_rooms.each do |room|
      if room.board.nil?
        @debating_number += 1
      end
    end
    return @debating_number
  end

  private
  # 参加したRoom
  def participated_rooms
    participated_rooms = Room.where(user_id: @user.id) + Room.where(opponent_id: @user.id)
  end

  def match_number
    match_number = participated_rooms.count
  end

end
