class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :prod_name
      t.float :cost
      t.references :categories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
