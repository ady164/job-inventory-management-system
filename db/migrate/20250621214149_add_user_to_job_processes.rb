class AddUserToJobProcesses < ActiveRecord::Migration[8.0]
  def change
    add_reference :job_processes, :user, foreign_key: true
  end
end
