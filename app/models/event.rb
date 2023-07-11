class Event < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  has_one :room_url
  has_many :users, through: :bookings
  has_one :chatroom
  after_save :event_chatroom

  private

  def event_chatroom
    Chatroom.create(name: title, event: self)
  end

  def create_or_update_room_url(url)
    if room_url
      room_url.update(url: url)
    else
      create_room_url(url: url)
    end
  end
end
