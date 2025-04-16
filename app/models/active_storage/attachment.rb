class ActiveStorage::Attachment < ApplicationRecord
  self.table_name = "active_storage_attachments"

  # ✅ Fix for ActiveStorage inverse error
  belongs_to :record, polymorphic: true, inverse_of: :attachments, optional: true

  # ✅ Allow search/filter in ActiveAdmin (if needed)
  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "record_type", "record_id", "blob_id", "created_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["blob"]
  end
end
