class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisherName
      t.string :url
      t.date :salesDate
      t.string :isbn
      t.string :imageUrl

      t.timestamps
    end
  end
end
