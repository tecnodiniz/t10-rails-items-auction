class CreateFinalizeds < ActiveRecord::Migration[7.0]
  def change
    create_table :finalizeds do |t|
      t.references :lot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
