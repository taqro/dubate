class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreugn_key: true
      t.timestamps
    end
  end
end
