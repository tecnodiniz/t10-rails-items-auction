class AddStatusToUserMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :user_messages, :status, :integer
  end
end
