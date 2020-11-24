class RenameOpponentColumnToRooms < ActiveRecord::Migration[6.0]
  def change
    rename_column :rooms, :opponent, :opponent_id
  end
end
