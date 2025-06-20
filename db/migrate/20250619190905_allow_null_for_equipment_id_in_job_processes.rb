class AllowNullForEquipmentIdInJobProcesses < ActiveRecord::Migration[8.0]
  def change
    change_column_null :job_processes, :equipment_id, true
  end
end
