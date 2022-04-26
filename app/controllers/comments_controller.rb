class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    comment = current_user.Comments.build(comment_params)
    comment.update!(debate_id: params[:id])
    comment.save!
    redirect_to debate_path(params[:id])
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
