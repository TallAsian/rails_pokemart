class ChangeAttrNameCustomers < ActiveRecord::Migration[7.1]
  def change
    rename_column :customers, :password, :encrypted_password
  end
end
