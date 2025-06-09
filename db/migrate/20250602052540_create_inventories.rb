class CreateInventories < ActiveRecord::Migration[8.0]
  def change
    create_table :inventories do |t|
      t.string :name
      t.string :product_number
      t.string :brand
      t.text :description
      t.string :category
      t.integer :quantity
      t.integer :alert_quantity
      t.string :status

      t.timestamps
    end
  end
end
