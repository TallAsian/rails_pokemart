class Customer < ApplicationRecord
  belongs_to :provinces
  has_many :orders
end
