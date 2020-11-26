class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :winner

  private

  # 勝者を定義
  def winner
    @room = Room.find(params[:room_id])
    @winner_id = @room.board.user_id == @room.opponent_id ? @room.user_id : @room.opponent_id
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
