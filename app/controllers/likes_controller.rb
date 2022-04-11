class LikesController < ApplicationController
  before_action :debate_params

  def create
    @like = Like.new(user_id: current_user.id, debate_id: params[:debate_id])
    @like.save!
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, debate_id: params[:debate_id])
    @like.destroy
  end

  private

  def debate_params
    @debate = Debate.find(params[:debate_id])
  end
end
