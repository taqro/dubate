class DebatesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @q = Debate.ransack(params[:q]) #ransack(検索のgem)
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

    #コメント関連
    #comment
    @comment = current_user.Comments.build
    @comments = @debate.Comments

    #円グラフ用データ (参加者が揃っているときのみ定義する)
    if !(@debate.joined_user_id.nil?)
      @data = {@debate.created_user.name => @votes.where(debating_user_id: @debate.created_user.id).count, @debate.joined_user.name => @votes.where(debating_user_id: @debate.joined_user.id).count}
    end

    #gon
    gon.debate = @debate
  end

  def new
    @debate = current_user.create_debates.build
  end

  def create
    debate = current_user.create_debates.build(debate_params)
    if debate.save
      redirect_to debates_path
    else
      render :new
    end
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

  #投票を開始する（制限時間のパラメーターをjs側にgonで渡す？） 制限時間関係の機能は未完成 保留中 あとで作る
  def vote_start
    @debate = Debate.find(params[:id])
    @debate.update!(status: "voting") #投票開始状態
    #制限時間（ミリ秒で渡されている）
    limit = params[:limit].to_f
    #投票開始時刻（jsに渡すために時間を変換している）
    vote_start_at = @debate.updated_at.to_f * 1000
    #投票終了時刻
    @time_limit = vote_start_at + limit

    redirect_back fallback_location: root_path
  end

  #投票を終了する（winorloseの勝者、敗者のカラムにそれぞれのuser_idを入れるアクションを呼び出す）
  def vote_finish
    debate = Debate.find(params[:id])
    debate.update!(status: "after_vote", finished_at: Time.now) #投票終了状態

    created_user_votes = Vote.where(debate_id: debate.id ,debating_user_id: debate.created_user_id).count || 0 #議論作成者への投票数
    joined_user_votes = Vote.where(debate_id: debate.id ,debating_user_id: debate.joined_user_id).count || 0 #議論参加者への投票数

    #投票数が多い方が勝者、少ない方が敗者
    if created_user_votes > joined_user_votes
      winorlose = debate.build_WinOrLose(loser_id: debate.joined_user_id, winner_id: debate.created_user_id)
      winorlose.save!
    elsif created_user_votes < joined_user_votes
    winorlose = debate.build_WinOrLose(loser_id: debate.created_user_id, winner_id: debate.joined_user_id)
    winorlose.save!
    elsif created_user_votes == joined_user_votes
      # もう一度投票
    end

    redirect_back fallback_location: root_path

  end

  #観戦者が議論'作成者'に投票する（議論参加者はできないように修正する）
  def vote_created_user
    debate = Debate.find(params[:id])
    vote = current_user.voting.build(debating_user_id: debate.created_user_id ,debate_id: params[:id])
    vote.save!
    redirect_back fallback_location: root_path
  end

  #観戦者が議論'参加者'に投票する（議論参加者はできないように修正する）
  def vote_joined_user
    debate = Debate.find(params[:id])
    vote = current_user.voting.build(debating_user_id: debate.joined_user_id ,debate_id: params[:id])
    vote.save!
    redirect_back fallback_location: root_path
  end

  private

  def debate_params
    params.require(:debate).permit(:agenda)
  end
end
