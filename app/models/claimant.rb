# frozen_string_literal: true

class Claimant < ApplicationRecord
  self.table_name = :claimants
  belongs_to :address, dependent: :destroy
  has_many :claim_claimants, dependent: :destroy
  accepts_nested_attributes_for :address
  def name
    "#{title} #{first_name} #{last_name}"
  end

  def self.ransackable_associations(auth_object = nil)
    %w[address claim_claimants]
  end
end
