class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: current_user.id, debate_id: params[:debate_id])
    @like.save!
    redirect_to debate_path(params[:debate_id])
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, debate_id: params[:debate_id])
    @like.destroy
    redirect_to debate_path(params[:debate_id])
  end
end
