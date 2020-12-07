class AddMonthToNewlies < ActiveRecord::Migration[5.2]
  def change
    add_column :newlies, :month, :string
  end
end
