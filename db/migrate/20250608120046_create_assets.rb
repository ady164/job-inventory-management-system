class CreateAssets < ActiveRecord::Migration[8.0]
  def change
    create_table :assets do |t|
      t.string :name
      t.string :tag
      t.string :brand
      t.string :model
      t.string :serial_number
      t.string :asset_type
      t.date :purchase_date
      t.string :remarks
      t.date :last_calibration_date
      t.integer :calibration_frequency_days

      t.timestamps
    end
  end
end
