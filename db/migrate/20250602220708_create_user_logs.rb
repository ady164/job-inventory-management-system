class CreateUserLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :user_logs do |t|
      t.string :login_email
      t.references :user, null: false, foreign_key: true
      t.boolean :success
      t.string :message
      t.timestamp :attempted_at

      t.timestamps
    end
  end
end
