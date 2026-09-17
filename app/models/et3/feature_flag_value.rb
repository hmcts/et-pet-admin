module Et3
  class FeatureFlagValue < Record
    belongs_to :feature_flag, primary_key: 'key', foreign_key: 'flag_key', required: false, class_name: 'Et3::FeatureFlag'

    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "flag_key", "id", "id_value", "updated_at", "valid_from", "valid_to", "value"]
    end
  end
end