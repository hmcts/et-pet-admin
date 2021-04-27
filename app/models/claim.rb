class Claim < ApplicationRecord
  self.table_name = :claims
  has_many :claim_claimants
  has_many :claim_respondents
  has_many :claim_representatives
  has_many :claim_uploaded_files
  has_many :secondary_claimants, through: :claim_claimants, class_name: 'Claimant', source: :claimant
  has_many :secondary_respondents, through: :claim_respondents, class_name: 'Respondent', source: :respondent
  has_many :secondary_representatives, through: :claim_representatives, class_name: 'Representative', source: :representative
  has_many :uploaded_files, through: :claim_uploaded_files
  has_many :events, as: :attached_to
  has_many :commands, as: :root_object
  belongs_to :primary_claimant, class_name: 'Claimant'
  belongs_to :primary_respondent, class_name: 'Respondent', optional: true
  belongs_to :primary_representative, class_name: 'Representative', optional: true
  belongs_to :office, foreign_key: :office_code, primary_key: :code
  has_many :exports, -> { order(id: :desc) }, as: :resource
  has_one :ccd_export, -> { ccd }, as: :resource, class_name: 'Export'

  scope :not_exported, -> { joins("LEFT JOIN \"exports\" ON \"exports\".\"resource_id\" = \"claims\".\"id\" AND \"exports\".\"resource_type\" = 'Claim'").where(exports: {id: nil}) }
  scope :not_exported_to_ecm, -> do
    joins("INNER JOIN external_systems ON external_systems.office_codes @> ARRAY[claims.office_code] AND external_systems.reference ~ 'ccd' AND external_systems.export_claims = TRUE")
      .where("(SELECT count(id) FROM exports WHERE exports.external_system_id = external_systems.id AND exports.resource_id = claims.id AND exports.resource_type='Claim' AND exports.state !='complete') > 0")
      .where("(SELECT count(id) FROM exports WHERE exports.external_system_id = external_systems.id AND exports.resource_id = claims.id AND exports.resource_type='Claim' AND exports.state = 'complete') = 0")
  end

  def name
    claimant = primary_claimant
    "#{claimant.title} #{claimant.first_name} #{claimant.last_name}"
  end

  def ecm_state
    export = last_ccd_export
    return '' if export.nil?
    export.state
  end

  def last_ccd_export
    @last__ccd_export ||= exports.ecm.first
  end

  def as_json(options = {})
    super(options.merge include: :uploaded_files, methods: [:ccd_state, :last_ccd_export])
  end
end
