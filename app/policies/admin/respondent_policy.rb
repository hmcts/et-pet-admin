module Admin
  class RespondentPolicy < ApplicationPolicy
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope
      end

    end
    def index?
      true
    end

    def update?
      true
    end

    def destroy
      true
    end
  end

end
