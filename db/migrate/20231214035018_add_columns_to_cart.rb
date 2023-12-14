class AddColumnsToCart < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :quantity, :integer
    add_reference :carts, :customers, foreign_key: true
    add_reference :carts, :products, foreign_key: true
  end
end
