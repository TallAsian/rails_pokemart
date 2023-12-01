class Product < ApplicationRecord
  belongs_to :category
  def self.ransackable_attributes(auth_object = nil)
    ["categories_id", "cost", "created_at", "id", "id_value", "prod_name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
