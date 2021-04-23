class Post < ApplicationRecord
  validates :title, presence: true, unless: -> { content.present? || ancestry? }
  validates :content, presence: true, unless: -> { title.present? || ancestry? }
  belongs_to :author, class_name: "User"
  has_ancestry
  has_many :post_notes, dependent: :destroy
  has_many :comments, through: :post_notes, source: :note, source_type: "Comment"
  has_many :likes, through: :post_notes, source: :note, source_type: "Like"

  def empty_reblog?
    !title.present? && !content.present?
  end

  def notes
    root.post_notes.order(created_at: :desc).map(&:note)
  end

  def thread
    path
  end
end
