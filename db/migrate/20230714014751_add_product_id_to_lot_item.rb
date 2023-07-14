class AddProductIdToLotItem < ActiveRecord::Migration[7.0]
  def change
    add_column :lot_items, :product_id, :integer, references: :product_id
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
