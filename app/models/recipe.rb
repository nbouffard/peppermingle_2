class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredient_recipes
  has_many :ingredients, through: :ingredient_recipes, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_many_attached :images

  SEASONS = ["Autumn", "Summer", "Winter", "Spring", "Christmas"]
  MEAL_TYPES = ["Breakfast", "Dessert", "Dinner", "Lunch", "Snacks", "Appetizers"]
  DIET = ["Vegan", "Dairy free", "Gluten free", "Nut free", "Vegetarian", "pescatarian"]
  validates :title, :description, :ingredients, :cuisine, :difficulty, :directions, :servings, presence: true
  validates :prep_time, :total_time, :servings, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # validates :season, inclusion: { in: SEASONS }
  # validates :meal_type, inclusion: { in: MEAL_TYPES }
  # validates :dietary_requirements, inclusion: { in: DIET }

  include PgSearch::Model
  pg_search_scope :filter_recipes,
                  against: %i[meal_type season dietary_requirements title cuisine difficulty total_time ingredients],
                  using: {
                    tsearch: { prefix: true }
                  }
end
