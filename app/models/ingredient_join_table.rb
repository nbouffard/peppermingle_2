class IngredientJoinTable < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  accepts_nested_attributes_for :ingredient, allow_destroy: true

  include PgSearch::Model
  pg_search_scope :search_by_ingredient_name, associated_against: {
    ingredient: [:name]
  }, using: {
    tsearch: { prefix: true },
    trigram: { threshold: 0.2 }
  }

  def self.search(query)
    search_by_ingredient_name(query)
  end
end
