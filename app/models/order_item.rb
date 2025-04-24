class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :beat

  before_create :store_unit_price

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "order_id", "beat_id", "quantity", "created_at", "updated_at"]
  end
  
  def total_price
    unit_price * quantity
  end

  private

  def store_unit_price
    self.unit_price ||= beat.price
  end

end
