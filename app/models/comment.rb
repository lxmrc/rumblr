class Comment < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_one :post_note, as: :note, dependent: :destroy
  has_one :post, through: :post_note
end
