class AddStatusToDebates < ActiveRecord::Migration[6.1]
  def change
    add_column :debates, :status, :string
  end
end
