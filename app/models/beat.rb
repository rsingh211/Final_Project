class Beat < ApplicationRecord
  has_one_attached :cover_image
  has_one_attached :audio_file
  belongs_to :category

  validates :title, :description, :genre, :price, :license_type, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "genre", "id", "license_type", "price", "title", "updated_at", "category_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "audio_file_attachment", "audio_file_blob", "cover_image_attachment", "cover_image_blob"]
  end
end
