class DebatesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @debate = current_user.create_debates.build
  end

  def create
  end

  def destroy
  end

  def edit
  end
end
