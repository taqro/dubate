class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id]) ? User.find(params[:id]) : current_user #三項演算子
    @rooms = @user.rooms.order(:id)
  end
end
