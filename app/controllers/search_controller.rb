class SearchController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    @results = []
    @recipes = Recipe.search(params[:q])
    @events = Event.search(params[:q])
    @ingredient_join_tables = IngredientJoinTable.search(params[:q])

    if params[:date].present?
      @events = @events.filter_by_date(params[:date])
    end

    @results = @recipes + @events + @ingredient_join_tables.map(&:recipe)
    @results = @results.uniq
    @results += IngredientJoinTable.search_by_ingredient_name(params[:q])

    @results = @results.uniq
  end
end
