class RemovePostFromLikes < ActiveRecord::Migration[6.1]
  def change
    remove_reference :likes, :post, null: false, foreign_key: true
  end
end
