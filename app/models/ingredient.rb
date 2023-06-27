class Ingredient < ApplicationRecord
  has_many :ingredient_recipes, dependent: :destroy
  has_many :recipes, through: :ingredient_recipes
end
