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
  has_many :comments, foreign_key: :author_id, dependent: :destroy

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
end
