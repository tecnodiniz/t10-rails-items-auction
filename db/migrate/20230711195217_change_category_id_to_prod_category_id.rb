class ChangeCategoryIdToProdCategoryId < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :category_id, :prod_category_id
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
