class Provinces < ApplicationRecord
    has_many :customers
    def self.ransackable_attributes(auth_object = nil)
        ["GST", "HST", "PST", "created_at", "id", "id_value", "prov_name", "updated_at"]
    end
    def self.ransackable_associations(auth_object = nil)
        ["customers"]
    end
end
