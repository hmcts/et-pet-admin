class ExternalSystem < ApplicationRecord
  self.table_name = :external_systems

  has_many :configurations, class_name: 'ExternalSystemConfiguration'

  accepts_nested_attributes_for :configurations, reject_if: :all_blank

  def office_codes=(arr)
    super arr.reject(&:blank?)
  end
end
