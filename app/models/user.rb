class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  # validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates :username, format: {with: /\A[a-zA-Z0-9\-]+\z/}, length: {maximum: 32}

  extend FriendlyId
  friendly_id :username, use: :slugged

  has_one_attached :profile_picture
  has_many :posts, foreign_key: :author_id
  has_many :likes, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id", 
                                  dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id", 
                                  dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def to_s
    if deleted_at
      "[deleted]"
    else
      username
    end
  end

  def soft_delete
    update_attribute(:deleted_at, Time.current)
    comments.destroy_all
    likes.destroy_all
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def inactive_message
    !deleted_at ? super : :invalid
  end

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    @posts = Post.where("author_id IN (#{following_ids}) OR author_id = :user_id", user_id: id).order(created_at: :desc)
  end
end
