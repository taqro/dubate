class UsersController < ApplicationController
  def show
    #暫定的に自分だけのページを表示できるようにしておく
    @user = current_user
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(2)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end
end
