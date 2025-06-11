class AddJobToInventoryLogs < ActiveRecord::Migration[8.0]
  def change
    add_reference :inventory_logs, :job, null: false, foreign_key: true
  end
end
