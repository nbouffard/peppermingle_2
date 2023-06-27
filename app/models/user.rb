class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :recipes, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :user_name, uniqueness: true
  validate :date_of_birth_greater_than_18_years

  private

  def date_of_birth_greater_than_18_years
    if date_of_birth.present? && date_of_birth > 18.years.ago.to_date
      errors.add(:date_of_birth, 'must be at least 18 years ago')
    end
  end
end
