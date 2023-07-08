class RecipePolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(public: true)
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
end
