class Et3ReconciliationReport 
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :start_date, :date
  attribute :end_date, :date
  attribute :total_claim_count, :integer
  attribute :response_count, :integer
  attribute :total_response_count
  attribute :uptake

  def initialize(*)
    super
    @loaded = false
  end

  def load
    date_range = start_date.to_time.midnight..end_date.to_time.end_of_day
    base_scope = Claim.where(date_of_receipt: date_range)
    self.total_claim_count = base_scope.count
    self.response_count = base_scope.with_responses.distinct.count
    self.total_response_count = base_scope.with_responses.count
    self.uptake = total_response_count.to_f / total_claim_count.to_f
    @loaded = true
    self
  end

  def loaded?
    loaded
  end

  private

  attr_reader :loaded
end
