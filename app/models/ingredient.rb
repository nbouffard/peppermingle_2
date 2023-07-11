class Ingredient < ApplicationRecord
  has_many :ingredient_join_tables
  has_many :recipes, through: :ingredient_join_tables, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search, against: [:name],
    using: {
      tsearch: { prefix: true },
      trigram: { threshold: 0.2 }
    }
end
