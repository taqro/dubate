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
    debate.joined_user_id = 1
    debate.save!
    redirect_to debates_path
  end

  def destroy
  end

  def edit
  end

  private

  def debate_params
    params.require(:debate).permit(:agenda)
  end
end
