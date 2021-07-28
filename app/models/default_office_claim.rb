class DefaultOfficeClaim < Claim
  self.inheritance_column = :none
  default_scope -> { joins(:office).where(office: { is_default: true }) }
  scope :actioned, -> { rewhere(manually_actioned: true) }
  scope :not_actioned, -> { rewhere(manually_actioned: false) }
end
