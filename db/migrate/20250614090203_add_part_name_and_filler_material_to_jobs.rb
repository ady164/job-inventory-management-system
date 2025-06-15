class AddPartNameAndFillerMaterialToJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :jobs, :part_name, :string
    add_column :jobs, :filler_material, :string
  end
end
