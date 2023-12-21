module Admin
  class GenerateReference
  include ActiveModel::Model

  attr_accessor :postcode, :reference

  validates :postcode, postcode: true

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end

  def self.inheritance_column
    :type
  end

  def self.columns
    []
  end

  def self.base_class
    self
  end
  end
end
