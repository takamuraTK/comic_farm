class AddPublisherToBookseries < ActiveRecord::Migration[5.2]
  def change
    add_column :bookseries, :publisher, :string
  end
end
