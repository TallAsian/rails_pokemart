# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :category_id, presence: true
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :prod_name, presence: true, uniqueness: true
  validate :image_presence

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "cost", "created_at", "id", "id_value", "prod_name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  private

  def image_presence
    errors.add(:image, 'must be attached') unless image.attached?
  end
end
