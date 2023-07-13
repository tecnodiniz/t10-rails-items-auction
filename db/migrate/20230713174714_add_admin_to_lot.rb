class AddAdminToLot < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :administrator_id, :integer, references: :administrator
  end
end
