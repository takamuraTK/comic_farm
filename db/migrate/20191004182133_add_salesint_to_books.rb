class AddSalesintToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :salesint, :integer
  end
end
