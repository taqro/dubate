class DebatesController < ApplicationController
  def index
    # @debates = Debate.all
    @q = Debate.ransack(params[:q])
    @debates = @q.result(distinct: true).recent
  end

  def show
    @debate = Debate.find(params[:id])
    # 議論作成者以外の参加者が議論に参加したらjoined_user_idに代入
    if @debate.joined_user_id.nil? and @debate.created_user_id != current_user.id
      @debate.update!(joined_user_id: current_user.id, wanted: false, started_at: Time.now)
    end
    #投票
    @vote = Vote.find_by(debate_id: @debate.id, voted_user_id: current_user.id) #観戦者が投票したときのみ存在する
    @votes = Vote.where(debate_id: @debate.id)
    #converstions
    @conversations = @debate.Conversations

    #円グラフ用データ
    @data = {@debate.created_user.name => @votes.where(debating_user_id: @debate.created_user.id).count, @debate.joined_user.name => @votes.where(debating_user_id: @debate.joined_user.id).count}

    #gon
    gon.debate = @debate
  end

  def new
    @debate = current_user.create_debates.build
  end

  def create
    debate = current_user.create_debates.build(debate_params)
    debate.save!
    redirect_to debates_path
  end

  def destroy
    debate = Debate.find(params[:id])
    debate.destroy
    redirect_to debates_url
  end

  def edit
    @debate = Debate.find(params[:id])
  end

  def update
    debate = Debate.find(params[:id])
    debate.update!(debate_params)
    redirect_to debates_url
  end

  #降参する
  def surrender
    debate = Debate.find(params[:id])
    #降参したユーザーが議論を作成したユーザーの場合
    if current_user.id == debate.created_user_id
      winorlose = debate.build_WinOrLose(loser_id: debate.created_user_id, winner_id: debate.joined_user_id)
      winorlose.save!
      debate.update!(finished_at: Time.now)
      redirect_back fallback_location: root_path
    end
    #降参したユーザーが議論に参加したユーザーの場合
    if current_user.id == debate.joined_user_id
      winorlose = debate.build_WinOrLose(loser_id: debate.joined_user_id, winner_id: debate.created_user_id)
      winorlose.save!
      debate.update!(finished_at: Time.now)
      redirect_back fallback_location: root_path
    end
  end

  #投票を開始する（投票ボタンを押したときに、voteが作成される）
  def vote_start
    debate = Debate.find(params[:id])
    debate.update!(status: "voting") #投票開始状態
    vote = debate.build_Vote
    vote.save!
    redirect_back fallback_location: root_path
  end

  #投票を終了する
  def vote_finish

  end

  #観戦者が議論作成者に投票する
  def vote_created_user
    debate = Debate.find(params[:id])
    @vote = Vote.find_by(debate_id: params[:id])
    @vote.update!(voted_user_id: current_user.id, debating_user_id: debate.created_user_id)
    redirect_back fallback_location: root_path
  end
  #観戦者が議論参加者に投票する
  def vote_joined_user
    debate = Debate.find(params[:id])
    @vote = Vote.find_by(debate_id: params[:id])
    @vote.update!(voted_user_id: current_user.id, debating_user_id: debate.joined_user_id)
    redirect_back fallback_location: root_path
  end

  private

  def debate_params
    params.require(:debate).permit(:agenda)
  end
end
