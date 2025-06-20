class CreateJobMeasurementReferences < ActiveRecord::Migration[8.0]
  def change
    create_table :job_measurement_references do |t|
      t.references :job, null: false, foreign_key: true
      t.json :diameter
      t.json :length
      t.json :runout

      t.timestamps
    end
  end
end
