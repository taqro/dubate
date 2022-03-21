class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed

  has_many :followers, through: :passive_relationships, source: :follower

  #debate
  has_many :create_debates, class_name: "Debate",
                            foreign_key: "created_user",
                            dependent: :destroy

  has_many :join_debates, class_name: "Debate",
                          foreign_key: "joined_user_id",
                          dependent: :destroy

  #以下、フォロー関連のメソッド
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
