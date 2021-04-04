class Post < ApplicationRecord
  validates :body, presence: true
  belongs_to :author, class_name: 'User'
  has_ancestry
  has_many :post_notes, dependent: :destroy
  has_many :comments, through: :post_notes, source: :note, source_type: 'Comment'
  has_many :likes, through: :post_notes, source: :note, source_type: 'Like'

  def notes
    root.post_notes.map(&:note)
  end
end
