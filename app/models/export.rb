# frozen_string_literal: true
class Export < ApplicationRecord
  self.table_name = :exports
  belongs_to :resource, polymorphic: true
  belongs_to :external_system
  has_many :events, class_name: 'ExportEvent', dependent: :destroy

  scope :ccd, -> { joins(:external_system).where('external_systems.reference LIKE \'ccd_%\'') }

  def external_data
    return {} if key_event.nil?
    key_event.data['external_data']
  end

  def percent_complete
    return 100 if events.complete.first
    key_event&.percent_complete || 0
  end

  def message
    key_event&.message || ''
  end

  private

  def key_event
    @key_event ||= begin
                     complete = events.complete.last
                     return complete if complete
                     failed = events.failed.last
                     return failed if failed
                     erroring = events.erroring.last
                     return erroring if erroring
                     events.last
                   end
  end

  def self.ransackable_associations(auth_object = nil)
    ["events", "external_system", "resource"]
  end
end
