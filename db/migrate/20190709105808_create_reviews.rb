class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.text :content
      t.string :head
      t.float :point
      t.index [:user_id, :book_id], unique: true

      t.timestamps
    end
  end
end
