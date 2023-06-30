class IngredientJoinTable < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  accepts_nested_attributes_for :ingredient, allow_destroy: true
end
