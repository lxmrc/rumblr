class RemovePostFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :post, null: false, foreign_key: true
  end
end
