class AddSequenceIndexToJobProcessTypes < ActiveRecord::Migration[8.0]
  def change
    add_column :job_process_types, :sequence_index, :integer
  end
end
