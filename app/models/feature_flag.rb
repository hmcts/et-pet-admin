class FeatureFlag < ApplicationRecord
  has_many :values, dependent: :destroy, class_name: '::FeatureFlagValue', primary_key: 'key', foreign_key: 'flag_key'
  accepts_nested_attributes_for :values, allow_destroy: true
  def self.ransackable_associations(auth_object = nil)
    %w[values]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at default_value id id_value key name updated_at]
  end

end