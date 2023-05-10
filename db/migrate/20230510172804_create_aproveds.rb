class CreateAproveds < ActiveRecord::Migration[7.0]
  def change
    create_table :aproveds do |t|
      t.references :lot, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :date_aproved

      t.timestamps
    end
  end
end
