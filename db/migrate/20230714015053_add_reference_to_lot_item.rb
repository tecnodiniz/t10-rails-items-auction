class AddReferenceToLotItem < ActiveRecord::Migration[7.0]
  def change
    change_column :lot_items, :product_id, :integer, references: :products
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
