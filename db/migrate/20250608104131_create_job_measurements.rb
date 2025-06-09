class CreateJobMeasurements < ActiveRecord::Migration[8.0]
  def change
    create_table :job_measurements do |t|
      t.references :job_process, null: false, foreign_key: true
      t.references :measurement_type, null: false, foreign_key: true
      t.integer :order_index
      t.integer :measurement_index
      t.string :name
      t.decimal :value
      t.string :remarks

      t.timestamps
    end
  end
end
