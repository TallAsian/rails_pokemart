class AddColumnToProvinces < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :province_name, :string
    add_column :carts, :GST, :decimal
    add_column :carts, :PST, :decimal
    add_column :carts, :HST, :decimal
  end
end
