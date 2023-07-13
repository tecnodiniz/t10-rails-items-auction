class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :cod
      t.string :name
      t.integer :width
      t.integer :height
      t.integer :weight
      t.integer :depth
      t.integer :status
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
