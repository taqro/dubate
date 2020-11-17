class AddNameToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :name, :text, null: false
  end
end
