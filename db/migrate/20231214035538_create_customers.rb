class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :cust_name
      t.references :provinces, null: false, foreign_key: true

      t.timestamps
    end
  end
end
