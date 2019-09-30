class AddSeriesToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :series, :string
  end
end
