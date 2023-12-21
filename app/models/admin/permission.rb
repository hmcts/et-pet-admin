module Admin
  class Permission < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
      %w[created_at id id_value name updated_at]
    end
  end
end
