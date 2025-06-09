class AddBrandToInventories < ActiveRecord::Migration[8.0]
  def change
    add_column :inventories, :brand, :string
  end
end
