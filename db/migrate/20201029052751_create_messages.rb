class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
    add_index :messages, [:user_id, :created_at], unique: true
    add_index :messages, [:room_id, :created_at], unique: true
  end
end
