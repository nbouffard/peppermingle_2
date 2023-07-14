class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.bookings.includes(event: :chatroom).map { |booking| booking.event.chatroom }
    end
  end

  def show?
    record.event.user == user || record.event.bookings.find_by(user: user)
  end

  def index?
    record.event.user == user || record.event.bookings.find_by(user: user)
  end
end
