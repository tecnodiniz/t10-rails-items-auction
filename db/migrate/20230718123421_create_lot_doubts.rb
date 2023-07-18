class CreateLotDoubts < ActiveRecord::Migration[7.0]
  def change
    create_table :lot_doubts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lot, null: false, foreign_key: true
      t.string :doubt

      t.timestamps
    end
  end
end
