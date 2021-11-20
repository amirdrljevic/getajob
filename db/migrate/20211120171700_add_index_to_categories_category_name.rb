class AddIndexToCategoriesCategoryName < ActiveRecord::Migration[6.1]
  def change
    add_index :categories, :category_name, unique: true
  end
end
