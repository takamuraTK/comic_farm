class CreateBookseries < ActiveRecord::Migration[5.2]
  def change
    create_table :bookseries do |t|
      t.string :title, unique: true

      t.timestamps
    end
  end
end
