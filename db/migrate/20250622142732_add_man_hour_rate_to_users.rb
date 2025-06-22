class AddManHourRateToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :man_hour_rate, :decimal
  end
end
