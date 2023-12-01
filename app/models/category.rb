class Category < ApplicationRecord
    has_many :products
    def self.ransackable_attributes(auth_object = nil)
        ["cat_name", "created_at", "id", "id_value", "updated_at"]
    end
    def self.ransackable_associations(auth_object = nil)
        ["products"]
    end
end
