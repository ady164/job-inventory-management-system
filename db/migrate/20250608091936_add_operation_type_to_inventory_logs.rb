class AddOperationTypeToInventoryLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :inventory_logs, :operation_type, :string
  end
end
