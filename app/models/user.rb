class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates :username, format: { with:  /\A[a-zA-Z0-9\-]+\z/ }, length: { maximum: 32 }

  extend FriendlyId
  friendly_id :username, use: :slugged

  has_one_attached :profile_picture
  has_many :posts, foreign_key: :author_id
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def to_s
    username
  end
end
