class Customer < ApplicationRecord
  belongs_to :province  
  has_many :orders

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :province_id, presence: true
  end