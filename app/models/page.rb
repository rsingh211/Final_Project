class Page < ApplicationRecord

    # Allow Ransack to search these fields
    def self.ransackable_attributes(auth_object = nil)
      ["id", "title", "content", "created_at", "updated_at"]
    end
  
  end
  