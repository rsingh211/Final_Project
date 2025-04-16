class Order < ApplicationRecord
belongs_to :customer, optional: true
belongs_to :user, optional: true

has_many :order_items
has_many :beats, through: :order_items

end
