class Post < ApplicationRecord
  validates :body, presence: true
  belongs_to :author, class_name: 'User'
  has_ancestry
  has_many :post_notes, dependent: :destroy
  has_many :comments, through: :post_notes, source: :note, source_type: 'Comment'
  has_many :likes, through: :post_notes, source: :note, source_type: 'Like'

  def original_post
    root
  end

  def notes
    original_post.subtree.each_with_object([]) do |post, notes|
      notes << post 
      notes.concat(post.post_notes.map(&:note))
    end.drop(1)
  end
end
