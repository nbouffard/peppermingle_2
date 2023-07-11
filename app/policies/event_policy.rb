class EventPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def destroy?
    record.user == user
  end

  def edit?
    update?
  end

  def destroy_room_url?
    user == record.user
  end

  def trigger_api?
    user == record.user
  end

  def room_url?
    true
  end

  def update?
    record.user == user
  end
end
