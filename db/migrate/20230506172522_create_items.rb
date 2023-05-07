class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :url_img
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :depth
      t.string :code
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
