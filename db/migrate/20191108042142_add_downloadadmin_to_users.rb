class AddDownloadadminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :downloadadmin, :boolean, default: false
  end
end
