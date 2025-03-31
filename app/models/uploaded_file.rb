class UploadedFile < ApplicationRecord
  self.table_name = :uploaded_files
  has_one_attached :file
  has_many :claim_uploaded_files, dependent: :destroy
  has_many :response_uploaded_files, dependent: :destroy
  scope :user_only, -> { where "filename LIKE '%.pdf' OR filename LIKE '%.rtf' OR filename LIKE '%.csv'" }
  scope :et3_user_files, -> { where(filename: %w[et3_atos_export.pdf additional_information.rtf]) }
  enum :file_scope, { user: 'user', system: 'system' }, suffix: true

  def self.ransackable_associations(auth_object = nil)
    %w[claim_uploaded_files file_attachment file_blob response_uploaded_files]
  end

  def content_type
    file&.attachment&.blob&.content_type
  end
end
