class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :debating_number, :waiting_number, :participated_rooms


  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms.order(:id)
    # 負け数
    @lose_number = @user.boards.count
    # 勝数
    @win_number = win_number
    # 総対戦数
    @matched_number = match_number - debating_number - waiting_number
    # いいねした数
    @likes = Like.where(user_id: @user.id)
    # 相手との総対戦数（他のユーザーのプロフィールページで表示）
    @matched_to_you_number = matched_to_you_number
  end

  # 議論中のRoom数、つまりまだboardが作成されていない、かつroom.opponent_idが存在する
  def debating_number
    @debating_number = 0
    participated_rooms.each do |room|
      if room.board.nil? && !room.opponent_id.nil?
        @debating_number += 1
      end
    end
    @debating_number
  end

  # 相手を探し中のRoom数、つまりroom.opponent_idが存在しない
  def waiting_number
    open_rooms = @user.rooms
    @waiting_number = 0
    open_rooms.each do |room|
      if room.opponent_id.nil?
        @waiting_number += 1
      end
    end
    @waiting_number
  end

  #? 参加したRoom、つまりroomのuser_idかopponent_idに自分のidが入っている まだ決着がついていないつまり議論中のものもカウントしてしまっている？
  def participated_rooms
    participated_rooms = Room.where(user_id: @user.id) + Room.where(opponent_id: @user.id)
  end

  # 参加したRoom数
  def match_number
    match_number = participated_rooms.count
  end

  # 勝数、つまり参加しているかつboardが作成されていて、そのuser_idが相手のもの
  def win_number
    @win_number = 0
    participated_rooms.each do |room|
      if !room.board.nil? && room.board.user_id != @user.id
        @win_number += 1
      end
    end
    @win_number
  end

  def matched_to_you_number #? 相手との対戦数 表示されないのはなぜ？
    matche_to_you_rooms = Room.where(user_id: @user.id, opponent_id: current_user.id) + Room.where(user_id: current_user.id, opponent_id: @user.id)
    @mathed_to_you_number = 0
    matche_to_you_rooms.each do |room|
      if !room.board.nil?
        @mathed_to_you_number += 1
      end
    end
    # @matched_to_you_number
    matche_to_you_rooms.count
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
