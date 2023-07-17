class CreateBlockedCpfs < ActiveRecord::Migration[7.0]
  def change
    create_table :blocked_cpfs do |t|
      t.references :user, foreign_key: true
      t.string :cpf

      t.timestamps
    end
  end
end
