class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(room_id: params[:room_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @room = Room.find(params[:room_id])
    @like = current_user.likes.find_by(room_id: @room.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end