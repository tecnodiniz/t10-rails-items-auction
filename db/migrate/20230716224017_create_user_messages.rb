class CreateUserMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :user_messages do |t|
      t.references :user, null: false, foreign_key: true
      t.string :from_email
      t.string :message

      t.timestamps
    end
  end
end
