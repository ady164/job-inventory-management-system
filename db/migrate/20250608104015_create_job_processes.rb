class CreateJobProcesses < ActiveRecord::Migration[8.0]
  def change
    create_table :job_processes do |t|
      t.references :job_process_type, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.integer :order_index
      t.string :status

      t.timestamps
    end
  end
end
