class Event < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  has_many :users, through: :bookings
  has_one :chatroom
  after_save :event_chatroom

  private

  def event_chatroom
    Chatroom.create(name: title, event: self)
  end
end
