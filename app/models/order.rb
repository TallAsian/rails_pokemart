class Order < ApplicationRecord
  belongs_to :customer, foreign_key: 'customers_id'
  belongs_to :product, foreign_key: 'products_id'
end
