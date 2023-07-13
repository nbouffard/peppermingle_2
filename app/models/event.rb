class Event < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  has_one :room_url
  has_many :users, through: :bookings
  has_one :chatroom, dependent: :destroy
  after_save :event_chatroom

  def self.filter_by_date(date)
    where(date: date)
  end

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

  include PgSearch::Model
  pg_search_scope :search, against: [:title, :description, :date],
    using: {
      tsearch: { prefix: true },
      trigram: { threshold: 0.2 }
    }
end
