class RecipePolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      scope.all
    end
  end

  def update?
    user&.id == record.user_id
  end

  def edit?
    update?
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def destroy?
    user&.id == record.user_id
  end
end
