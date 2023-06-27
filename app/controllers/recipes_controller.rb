class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_recipe, only: %i[edit update]

  def index
    if params[:query].present?
      @recipes = policy_scope(Recipe).filter_recipes(params[:query])
    else
      @recipes = policy_scope(Recipe)
    end
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
    # @recipe.build_ingredients
  end

  def show
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    authorize @recipe
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      puts @recipe.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe.ingredients.build if @recipe.ingredients.empty?
    authorize @recipe
  end

  def update
    authorize @recipe
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "Recipe updated successfully."
    else
      render :edit
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :meal_type,
                                   :season, :dietary_requirements, :cuisine, :prep_time,
                                   :total_time, :difficulty, :servings, :directions, ingredients_attributes: [:id, :amount, :name, :_destroy])
  end
end
