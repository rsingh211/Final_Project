class ActiveStorage::Blob < ApplicationRecord
    self.table_name = "active_storage_blobs"
  
    has_many :attachments,
             class_name: "ActiveStorage::Attachment",
             foreign_key: "blob_id",
             dependent: :destroy
  
    def self.ransackable_attributes(auth_object = nil)
      ["id", "filename", "content_type", "metadata", "byte_size", "checksum", "created_at"]
    end
  end
  