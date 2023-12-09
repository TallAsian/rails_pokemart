class ChangeForeignKeyNameInProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :categories_id, :category_id
  end
end
