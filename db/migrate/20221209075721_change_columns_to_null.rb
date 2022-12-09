class ChangeColumnsToNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tags, :user_id, true
  end
end
