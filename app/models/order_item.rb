class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :beat

  def self.ransackable_attributes(auth_object = nil)
    ["id", "order_id", "beat_id", "quantity", "created_at", "updated_at"]
  end
  
end
