class AnotherRemove < ActiveRecord::Migration[7.0]
  def change
    remove_column :lot_items, :products_id
  end
end
