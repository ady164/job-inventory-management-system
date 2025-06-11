class ChangeJobIdNullOnInventoryLogs < ActiveRecord::Migration[8.0]
  def change
    change_column_null :inventory_logs, :job_id, true
  end
end
