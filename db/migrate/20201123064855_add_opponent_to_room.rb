class AddOpponentToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :opponent, :integer
  end
end
