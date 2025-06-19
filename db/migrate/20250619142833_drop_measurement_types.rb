class DropMeasurementTypes < ActiveRecord::Migration[8.0]
  def up
    # Remove the foreign key constraint first
    remove_foreign_key :job_measurements, :measurement_types

    # Optional: remove the column if you don't need it anymore
    remove_column :job_measurements, :measurement_type_id

    # Now you can safely drop the table
    drop_table :measurement_types
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end