class AddAssetRefToJobProcesses < ActiveRecord::Migration[8.0]
  def change
    add_reference :job_processes, :asset, null: false, foreign_key: true
  end
end
