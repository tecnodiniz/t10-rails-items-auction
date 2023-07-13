class ChangeCodeToUniqueInProduct < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :cod, :string, unique: true
  end
end
