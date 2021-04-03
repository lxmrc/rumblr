class Like < ApplicationRecord
  belongs_to :user
  has_one :post_note, as: :note, dependent: :destroy
  has_one :post, through: :post_note
end
