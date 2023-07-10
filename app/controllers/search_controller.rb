class SearchController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    @results = []
    @recipes = Recipe.search(params[:q])
    @events = Event.search(params[:q])
    Rails.logger.debug("Events after search: #{@events.inspect}")
    @ingredient_join_tables = IngredientJoinTable.search(params[:q])

    if params[:date].present?
      Rails.logger.debug("Params date: #{params[:date]}")
      @events = @events.filter_by_date(params[:date])
      Rails.logger.debug("Events after date filter: #{@events.inspect}")
    end

    @results = @recipes + @events + @ingredient_join_tables.map(&:recipe)
    @results = @results.uniq
    @results += IngredientJoinTable.search_by_ingredient_name(params[:q])
    @results = @results.uniq
  end
end
