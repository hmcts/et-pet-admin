class Office < ApplicationRecord
  self.table_name = :offices

  has_many :office_post_codes
  scope :excluding_default, -> { where(is_default: false) }

  def self.ransackable_associations(auth_object = nil)
    ['office_post_codes']
  end
end
