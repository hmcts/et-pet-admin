class Representative < ApplicationRecord
  self.table_name = :representatives
  belongs_to :address, dependent: :destroy
  accepts_nested_attributes_for :address

  def self.ransackable_associations(_auth_object = nil)
   ["address"]
  end
end
