class Province < ApplicationRecord
    has_many :users
    has_many :customers
  
    def self.ransackable_attributes(auth_object = nil)
      ["id", "name", "code", "gst", "pst", "hst", "created_at", "updated_at"]
    end
  end
  