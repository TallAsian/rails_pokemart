class AboutPage < ApplicationRecord
  validates :content, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "should be 10 digits" }
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "is not a valid email address" }
  validates :address, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["content", "phone_number", "email", "address", "created_at", "id", "id_value", "updated_at"]
  end
end