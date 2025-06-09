class AddImagePathToInventories < ActiveRecord::Migration[8.0]
  def change
    add_column :inventories, :image_path, :string
  end
end
