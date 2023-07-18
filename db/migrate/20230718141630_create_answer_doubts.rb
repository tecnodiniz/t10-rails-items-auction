class CreateAnswerDoubts < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_doubts do |t|
      t.references :lot_doubt, null: false, foreign_key: true
      t.references :administrator, null: false, foreign_key: true
      t.string :answer

      t.timestamps
    end
  end
end
