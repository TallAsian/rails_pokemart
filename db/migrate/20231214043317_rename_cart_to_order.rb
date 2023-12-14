class RenameCartToOrder < ActiveRecord::Migration[7.1]
  def change
    rename_table :carts, :orders
  end
end
