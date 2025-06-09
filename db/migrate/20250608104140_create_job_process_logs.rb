class CreateJobProcessLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :job_process_logs do |t|
      t.references :job_process, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamp :start_time
      t.timestamp :end_time
      t.json :measurement_data
      t.json :process_parameter
      t.string :status

      t.timestamps
    end
  end
end
