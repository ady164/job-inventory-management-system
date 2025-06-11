class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :job_reference_number
      t.string :vessle_name
      t.date :required_date
      t.string :part_type
      t.string :part_model
      t.string :base_material
      t.string :status
      t.integer :created_by

      t.timestamps
    end
  end
end
