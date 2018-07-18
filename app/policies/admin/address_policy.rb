module Admin
  class AddressPolicy < ApplicationPolicy
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope
      end
    end

    def index?
      user.is_admin? || user.permission_names.include?('read_addresses')
    end

    def show?
      user.is_admin? || user.permission_names.include?('read_addresses')
    end

    def update?
      user.is_admin? || user.permission_names.include?('edit_addresses')
    end

    def destroy
      user.is_admin? || user.permission_names.include?('delete_addresses')
    end
  end

end
