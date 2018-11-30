class ExternalSystem < ApplicationRecord
  self.table_name = :external_systems

  has_many :configurations, class_name: 'ExternalSystemConfiguration'

  def office_codes=(arr)
    super arr.reject(&:blank?)
  end
end
