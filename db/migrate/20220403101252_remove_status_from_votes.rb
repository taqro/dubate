class RemoveStatusFromVotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :votes, :status, :string
  end
end
