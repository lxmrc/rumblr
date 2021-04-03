class CreatePostNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_notes do |t|
      t.references :post, null: false, foreign_key: true
      t.references :note, null: false, polymorphic: true

      t.timestamps
    end
  end
end
