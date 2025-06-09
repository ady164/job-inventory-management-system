class CreateInventoryLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :inventory_logs do |t|
      t.references :inventory, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :quantity
      t.string :status
      t.string :message

      t.timestamps
    end
  end
end
