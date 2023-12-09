class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "cost", "created_at", "id", "id_value", "prod_name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
