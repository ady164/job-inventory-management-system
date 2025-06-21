class AddOrderIndexToJobProcessLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :job_process_logs, :order_index, :integer
  end
end
