class AddWinnerandLoserToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :winner, :integer
    add_column :rooms, :loser, :integer
  end
end
