class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  extend FriendlyId
  friendly_id :username, use: :slugged
  has_one_attached :profile_picture
  has_many :posts, foreign_key: :author_id
end
