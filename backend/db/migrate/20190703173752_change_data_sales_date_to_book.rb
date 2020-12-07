class ChangeDataSalesDateToBook < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :salesDate, :string
  end
end
