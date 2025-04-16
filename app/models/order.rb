class Order < ApplicationRecord
belongs_to :customer, optional: true
belongs_to :user, optional: true

has_many :order_items
has_many :beats, through: :order_items

def self.ransackable_associations(auth_object = nil)
  ["user", "customer", "order_items", "beats"]
end

def self.ransackable_attributes(auth_object = nil)
  ["id", "total", "tax", "created_at", "updated_at", "user_id", "customer_id"]
end

end
