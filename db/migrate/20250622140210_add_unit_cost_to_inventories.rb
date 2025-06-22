class AddUnitCostToInventories < ActiveRecord::Migration[8.0]
  def change
    add_column :inventories, :unit_cost, :decimal
  end
end
