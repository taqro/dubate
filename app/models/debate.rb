class Debate < ApplicationRecord
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :Conversations, dependent: :destroy
  has_many :Comments, dependent: :destroy
  has_one :WinOrLose, dependent: :destroy
  has_many :Votes, dependent: :destroy
  belongs_to :created_user, class_name: "User"
  belongs_to :joined_user, class_name: "User", optional: true

  #scope
  scope :recent, -> {order(created_at: :desc)}

  #デフォルト値設定
  attribute :wanted, :boolean, default: true
  attribute :status, :string, default: 'before_vote'

  validates :created_user_id, presence: true
  validates :agenda, presence: true
  validates :wanted, inclusion: { in: [true, false] }


  # 議論関連

  # 議論作成者を返す
  def createdUser()
    User.find(self.created_user_id)
  end

  # 議論参加者を返す
  def joinnedUser()
    User.find(self.joined_user_id)
  end

  # 議論の勝者を返す
  def winUser()
    User.find(self.WinOrLose.winner_id)
  end

  # 議論の敗者を返す
  def loseUser()
    User.find(self.WinOrLose.loser_id)
  end

  #その議論に参加中のユーザーならtrueを返す
  def debating_user?(user)
    user.id == self.created_user_id or user.id == self.joined_user_id
  end


  # 参加者募集中かどうかで「募集中」、「議論中」を返す
  def wanted?()
    "議論相手募集中" if self.wanted
  end

  # 参加者が揃っているかどうか、つまり、議論が始まったかどうか
  def isStarted?()
    !self.joined_user_id.nil? and !self.started_at.nil?
  end

  # 議論の勝敗がついているかどうか
  def isFinished?()
    !self.WinOrLose.nil? and !self.finished_at.nil?
  end

end
