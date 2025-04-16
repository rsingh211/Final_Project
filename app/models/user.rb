class User < ApplicationRecord
  belongs_to :province, optional: true
  validates :address, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
