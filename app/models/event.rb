class Event < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
end
