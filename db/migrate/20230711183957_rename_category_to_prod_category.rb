class RenameCategoryToProdCategory < ActiveRecord::Migration[7.0]
  def change
    rename_table :categories, :prod_categories
  end
end
