class AddTitleToUserMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :user_messages, :title, :string
  end
end
