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
  end
end
