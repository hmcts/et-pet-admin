class Et3ReconciliationReportPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    user.is_admin? || user.permission_names.include?('read_et3_reconciliation_report')
  end

  def index?
    user.is_admin? || user.permission_names.include?('read_et3_reconciliation_report')
  end

  def show?
    user.is_admin? || user.permission_names.include?('read_et3_reconciliation_report')
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def perform?
    user.is_admin? || user.permission_names.include?('read_et3_reconciliation_report')
  end
end
