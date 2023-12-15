class Customer < ApplicationRecord
  belongs_to :provinces
  has_many :orders
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "cust_name", "email", "encrypted_password", "id", "id_value", "provinces_id", "remember_created_at", "updated_at"]
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
end
