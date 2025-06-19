class AddFieldsToJobProcesses < ActiveRecord::Migration[8.0]
  def change
    add_column :job_processes, :start_time, :datetime
    add_column :job_processes, :end_time, :datetime
    add_column :job_processes, :measurements, :json
  end
end
