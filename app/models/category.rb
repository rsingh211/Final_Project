class Category < ApplicationRecord
    has_many :beats
    validates :name, presence: true, uniqueness: true

  
    # Allow searchable attributes
    def self.ransackable_attributes(auth_object = nil)
      ["id", "name", "created_at", "updated_at"]
    end
  
    # Allow searchable associations (needed for related beat searches)
    def self.ransackable_associations(auth_object = nil)
      ["beats"]
    end
  end
  