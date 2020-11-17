class AddUserRefToRoom < ActiveRecord::Migration[6.0]
  def change
    
    change_column_null :rooms, :user_id, false
  end
end
