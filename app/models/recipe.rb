class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredient_join_tables, dependent: :destroy
  has_many :ingredients, through: :ingredient_join_tables, dependent: :destroy
  accepts_nested_attributes_for :ingredient_join_tables, allow_destroy: true
  has_many_attached :images

  SEASONS = ["Any", "Autumn", "Summer", "Winter", "Spring", "Christmas", "Easter"]
  MEAL_TYPES = ["Breakfast", "Dessert", "Dinner", "Lunch", "Snacks", "Appetizers", "Drinks"]
  DIET = ["Vegan", "Dairy free", "Gluten free", "Nut free", "Vegetarian", "Pescatarian"]
  validates :title, :description, :cuisine, :difficulty, :directions, :servings, presence: true
  validates :prep_time, :total_time, :servings, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # validates :season, inclusion: { in: SEASONS }
  # validates :meal_type, inclusion: { in: MEAL_TYPES }
  # validates :dietary_requirements, inclusion: { in: DIET }

  include PgSearch::Model
  pg_search_scope :filter_recipes,
                  against: %i[meal_type season dietary_requirements title cuisine difficulty total_time],
                  using: {
                    tsearch: { prefix: true }
                  }
end
