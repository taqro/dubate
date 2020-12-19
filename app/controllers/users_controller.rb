class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :debating_number, :waiting_number, :participated_rooms


  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms.order(:id)
    @lose_number = @user.boards.count　#負け数
    @win_number = match_number - @lose_number - debating_number-waiting_number-debating_number　#勝数
    @matched_number = match_number - debating_number-waiting_number #総対戦数

    @likes = Like.where(user_id: @user.id)
  end

  # 議論中のRoom数
  def debating_number
    @debating_number = 0
    participated_rooms.each do |room|
      if room.board.nil? and !(room.opponent_id.nil?)
        @debating_number += 1
      end
    end
    return @debating_number
  end

  # 相手を探し中のRoom数
  def waiting_number
    open_rooms = @user.rooms
    @waiting_number = 0
    open_rooms.each do |room|
      if room.opponent_id.nil?
        @waiting_number += 1
      end
    end
    return @waiting_number
  end

  # 参加したRoom
  def participated_rooms
    participated_rooms = Room.where(user_id: @user.id) + Room.where(opponent_id: @user.id)
  end

  #参加したRoom数
  def match_number
    match_number = participated_rooms.count
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

end
