class RemoveAtributeLotItem < ActiveRecord::Migration[7.0]
  def change
    remove_column :lot_items, :product_id
  end
end
