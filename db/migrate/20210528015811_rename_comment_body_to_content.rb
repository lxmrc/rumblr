class RenameCommentBodyToContent < ActiveRecord::Migration[6.1]
  def change
    change_table :comments do |t|
      t.rename :body, :content
    end
  end
end
