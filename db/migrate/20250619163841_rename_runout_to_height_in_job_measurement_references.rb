class RenameRunoutToHeightInJobMeasurementReferences < ActiveRecord::Migration[8.0]
  def change
    rename_column :job_measurement_references, :runout, :height
  end
end