class Order < ApplicationRecord
 STATUSES = %w[new paid shipped]
 validates :status, inclusion: { in: STATUSES }
after_initialize :set_default_status, if: :new_record?
belongs_to :customer, optional: true
belongs_to :user, optional: true

before_validation :set_default_status, on: :create

has_many :order_items
has_many :beats, through: :order_items

def store_tax_rates(province)
  self.gst = province.gst
  self.pst = province.pst
  self.hst = province.hst
  self.qst = province.qst
end

def self.ransackable_associations(auth_object = nil)
  ["user", "customer", "order_items", "beats"]
end

def self.ransackable_attributes(auth_object = nil)
  ["id", "total", "tax", "created_at", "updated_at", "user_id", "customer_id"]
end

def set_default_status
  self.status ||= 'new'
end



end
