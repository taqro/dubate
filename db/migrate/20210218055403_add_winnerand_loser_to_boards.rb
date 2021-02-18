class AddWinnerandLoserToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :winner, :integer
    add_column :boards, :loser, :integer
  end
end
