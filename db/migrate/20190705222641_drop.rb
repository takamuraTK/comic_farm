class Drop < ActiveRecord::Migration[5.2]
  def change
    drop_table :book_users
    drop_table :books_users
  end
end
