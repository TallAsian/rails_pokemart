class AddRememberableToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :remember_created_at, :datetime
  end
end
