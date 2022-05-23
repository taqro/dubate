class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end


  #フォロー関連
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  #勝敗数関連
  def wins
    @title = "勝った議論一覧"
    @user  = User.find(params[:id])
    @winorlose = WinOrLose.where(winner_id: @user.id)
    @debates = @user.win_debates
    render 'show_winorlose'
  end

  def loses
    @title = "負けた議論一覧"
    @user  = User.find(params[:id])
    @winorlose = WinOrLose.where(loser_id: @user.id)
    @debates = @user.lose_debates
    render 'show_winorlose'
  end
end
