class ChangeUserIdToBeNullableInUserLogs < ActiveRecord::Migration[8.0]
  def change
    change_column_null :user_logs, :user_id, true
  end
end
