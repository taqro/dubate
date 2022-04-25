class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #フォロー関連
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #勝敗数関連
  has_many :wins, class_name: "WinOrLose",
                  foreign_key: "winner_id",
                  dependent: :destroy
  has_many :loses, class_name: "WinOrLose",
                  foreign_key: "loser_id",
                  dependent: :destroy
  has_many :win_debates, through: :wins, source: :Debate
  has_many :lose_debates, through: :loses, source: :Debate

  #投票関連
  has_many :voting, class_name: "Vote",
                  foreign_key: "voted_user_id",
                  dependent: :destroy
  has_many :voted, class_name: "Vote",
                  foreign_key: "debating_user_id",
                  dependent: :destroy

  #debate
  has_many :create_debates, class_name: "Debate",
                            foreign_key: "created_user",
                            dependent: :destroy
  has_many :join_debates, class_name: "Debate",
                          foreign_key: "joined_user",
                          dependent: :destroy

  #conversation
  has_many :Conversations, dependent: :destroy

  #comment
  has_many :Comments, dependent: :destroy

  #like
  has_many :likes, dependent: :destroy
  has_many :liked_debates, through: :likes, source: :debate

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  #議論関連のメソッド
  #その議論に参加中のユーザーならtrueを返す
  def debating_user?(debate)
    self.id == debate.created_user_id or self.id == debate.joined_user_id
  end

  #like関連のメソッド
  #既にlikeしたか
  def liked?(debate)
    self.likes.exists?(debate_id: debate.id)
  end

  #フォロー関連のメソッド
  #ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  #ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #現在のユーザーがフォローしていたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

end
