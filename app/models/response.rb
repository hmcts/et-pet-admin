# frozen_string_literal: true
class Response < ApplicationRecord
  self.table_name = :responses

  belongs_to :respondent
  belongs_to :representative
  has_many :response_uploaded_files, dependent: :destroy
  has_many :uploaded_files, through: :response_uploaded_files
  has_many :exports, as: :resource
  has_many :commands, as: :root_object
  belongs_to :office
  has_many :events, as: :attached_to

  scope :not_exported, lambda {
                         joins("LEFT JOIN \"exports\" ON \"exports\".\"resource_id\" = \"responses\".\"id\" AND \"exports\".\"resource_type\" = 'Response'").where(exports: {id: nil})
                       }
  scope :not_exported_to_ccd, lambda {
                                joins("LEFT OUTER JOIN \"exports\" ON \"exports\".\"resource_id\" = \"responses\".\"id\" AND \"exports\".\"resource_type\" = 'Response' LEFT OUTER JOIN \"external_systems\" ON \"exports\".\"external_system_id\" = \"external_systems\".\"id\" AND \"external_systems\".\"reference\" ~ 'ccd'").where(external_systems: {id: nil})
                              }


  def self.ransackable_associations(auth_object = nil)
    ['commands', 'events', 'exports', 'office', 'representative', 'respondent', 'response_uploaded_files', 'uploaded_files']
  end

  def as_json(options = {})
    super(options.merge include: :uploaded_files, methods: [:ccd_state])
  end

  def name
    respondent.name
  end

  def ccd_state
    export = exports.ccd.last
    return '' if export.nil?
    export.state
  end
end
