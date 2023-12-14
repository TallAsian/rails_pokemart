class RemoveColumnsFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :province_name
    remove_column :orders, :GST
    remove_column :orders, :PST
    remove_column :orders, :HST
  end
end
