class AddColumnToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :selected, :boolean, default: false
  end
end
