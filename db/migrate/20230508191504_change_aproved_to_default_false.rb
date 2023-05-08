class ChangeAprovedToDefaultFalse < ActiveRecord::Migration[7.0]
  def change
    change_column :lots, :aproved, :boolean, default: false
  end
end
