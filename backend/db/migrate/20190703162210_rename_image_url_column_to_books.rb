class RenameImageUrlColumnToBooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :imageUrl, :image_url
  end
end
