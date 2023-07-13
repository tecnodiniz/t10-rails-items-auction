class RemoveUserIdFromLot < ActiveRecord::Migration[7.0]
  def change
    remove_column :lots, :user_id, :integer
  end
end
