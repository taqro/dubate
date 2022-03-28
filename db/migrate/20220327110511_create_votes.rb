class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :debate, foreign_key: true
      t.references :voted_user
      t.references :debating_user

      t.timestamps
    end
  end
end
