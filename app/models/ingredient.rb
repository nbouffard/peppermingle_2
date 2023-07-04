class Ingredient < ApplicationRecord
  has_many :ingredient_join_tables
  has_many :recipes, through: :ingredient_join_tables, dependent: :destroy
end
