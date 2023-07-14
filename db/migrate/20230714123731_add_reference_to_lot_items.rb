class AddReferenceToLotItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :lot_items, :products, foreign_key: true
  end
end
