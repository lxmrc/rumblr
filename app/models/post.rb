class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  validates :body, presence: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def notes
    (likes + comments).sort_by(&:created_at).reverse
  end
end
