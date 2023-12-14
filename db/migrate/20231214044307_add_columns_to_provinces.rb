class AddColumnsToProvinces < ActiveRecord::Migration[7.1]
  def change
    add_column :provinces, :province_name, :string
    add_column :provinces, :GST, :decimal
    add_column :provinces, :PST, :decimal
    add_column :provinces, :HST, :decimal
  end
end
