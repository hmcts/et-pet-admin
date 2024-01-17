class ExternalSystem < ApplicationRecord
  self.table_name = :external_systems

  scope :ccd_only, -> { where("reference LIKE 'ccd_%'") }
  has_many :configurations, class_name: 'ExternalSystemConfiguration'

  accepts_nested_attributes_for :configurations, reject_if: :all_blank

  def self.ransackable_associations(auth_object = nil)
    ['configurations']
  end

  def as_json(options = {})
    super(options.merge include: :configurations)
  end
  def office_codes=(arr)
    super arr.reject(&:blank?)
  end

  def config
    @config ||= configurations.inject({}) do |acc, configuration|
      acc[configuration.key.to_sym] = configuration.value
      acc
    end
  end
end
