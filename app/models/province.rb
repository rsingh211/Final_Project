class Province < ApplicationRecord
    has_many :users
    has_many :customers

    validates :name, presence: true
  validates :gst, :pst, :hst, :qst, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
    def self.ransackable_attributes(auth_object = nil)
      ["id", "name", "code", "gst", "pst", "hst", "created_at", "updated_at"]
    end
  end
  