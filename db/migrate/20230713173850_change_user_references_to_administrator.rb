class ChangeUserReferencesToAdministrator < ActiveRecord::Migration[7.0]
  def change
    change_column :lots, :user_id, :integer, references: :administrators
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
