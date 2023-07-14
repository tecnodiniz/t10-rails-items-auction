class AnotherReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :lot_items, :product, foreign_key: true, null: false
  end
end
