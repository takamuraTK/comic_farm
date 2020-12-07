class AddBookseriesIdToBooks < ActiveRecord::Migration[5.2]
  def change
    add_reference :books, :bookseries, foreign_key: true
  end
end
