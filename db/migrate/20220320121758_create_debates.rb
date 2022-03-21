class CreateDebates < ActiveRecord::Migration[6.1]
  def change
    create_table :debates do |t|
      t.integer :created_user_id
      t.integer :joined_user_id
      t.text :agenda
      t.boolean :wanted
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
    add_index :debates, :created_user_id
    add_index :debates, :joined_user_id
    add_index :debates, [:created_user_id, :created_at]
  end
end
