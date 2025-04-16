class Beat < ApplicationRecord
  has_one_attached :cover_image
  has_one_attached :audio_file

  belongs_to :category

  validates :title, :description, :genre, :price, :license_type, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  before_destroy :purge_attachments
    # New: created in the past 3 days
    scope :new_beats, -> { where('created_at >= ?', 3.days.ago) }

    # Recently updated: updated in last 3 days, but NOT created in last 3 days
    scope :recently_updated_beats, -> {
      where('updated_at >= ?', 3.days.ago)
        .where.not(id: new_beats.select(:id))
    }

  def purge_attachments
    cover_image.purge_later if cover_image.attached?
    audio_file.purge_later if audio_file.attached?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "genre", "id", "license_type", "price", "title", "updated_at", "category_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end

