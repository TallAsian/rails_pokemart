# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  has_many :orders

  validates :category_id, presence: true
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :prod_name, presence: true, uniqueness: true

  def add_to_cart(session, product_id, quantity)
    session[:cart] ||= []
    session[:cart] << self.id
    session[:cart].uniq!  # Ensure unique product IDs in the cart
    session[:quantity] ||= {}
    session[:quantity][product_id] = quantity
  end

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
