# app/models/about_page.rb
class AboutPage < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["content", "phone_number", "email", "address", "created_at", "id", "id_value", "updated_at"]
  end
end
