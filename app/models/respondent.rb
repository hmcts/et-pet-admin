# frozen_string_literal: true
class Respondent < ApplicationRecord
  self.table_name = :respondents
  belongs_to :address, dependent: :destroy
  belongs_to :work_address, class_name: 'Address', required: false, dependent: :destroy
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :work_address

  def self.ransackable_associations(auth_object = nil)
    %w[address work_address]
  end
end
