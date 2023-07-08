class IngredientJoinTable < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  accepts_nested_attributes_for :ingredient, allow_destroy: true

  include PgSearch::Model
  pg_search_scope :search, associated_against: {
    ingredient: [:name]
  }, using: {
    tsearch: { prefix: true }
  }
end
