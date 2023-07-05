class Event < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  has_one :room_url

  def create_or_update_room_url(url)
    if room_url
      room_url.update(url: url)
    else
      create_room_url(url: url)
    end
  end
end
