# frozen_string_literal: true
module Admin
  class UserRole < ApplicationRecord
    belongs_to :user
    belongs_to :role


    def self.ransackable_attributes(auth_object = nil)
      %w[id id_value role_id user_id]
    end
  end
end
