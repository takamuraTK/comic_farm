class CreateNewlies < ActiveRecord::Migration[5.2]
  def change
    create_table :newlies do |t|
      t.string :publisherName
      t.integer :counter

      t.timestamps
    end
  end
end
