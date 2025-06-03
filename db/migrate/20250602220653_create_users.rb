class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :pin_hash
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
