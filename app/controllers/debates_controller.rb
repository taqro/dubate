class DebatesController < ApplicationController
  def index
    @debates = Debate.all
  end

  def show
  end

  def new
    @debate = current_user.create_debates.build
  end

  def create
    debate = current_user.create_debates.build(debate_params)
    debate.joined_user_id = 1 #validationを通すために一時的に適当な値を入れている  後で直す。
    debate.save!
    redirect_to debates_path
  end

  def destroy
    debate = Debate.find(params[:id])
    debate.destroy
    redirect_to debates_url
  end

  def edit
  end

  private

  def debate_params
    params.require(:debate).permit(:agenda)
  end
end
