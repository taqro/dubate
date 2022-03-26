class CreateWinOrLoses < ActiveRecord::Migration[6.1]
  def change
    create_table :win_or_loses do |t|
      t.references :debate, unique: true
      t.references :winner
      t.references :loser

      t.timestamps
    end
  end
end
