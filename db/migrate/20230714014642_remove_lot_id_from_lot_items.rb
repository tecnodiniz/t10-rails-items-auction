class RemoveLotIdFromLotItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :lot_items, :item_id
  end
end
