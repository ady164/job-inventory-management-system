class DropJobMeasurements < ActiveRecord::Migration[8.0]
  def up
    drop_table :job_measurements
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
