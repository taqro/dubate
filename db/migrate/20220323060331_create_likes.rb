class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :debate, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    add_index :likes, [:debate_id, :user_id], unique: true
    add_index :likes, [:user_id, :created_at]
  end
end
