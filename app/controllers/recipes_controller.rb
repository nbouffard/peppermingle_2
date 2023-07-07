class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_recipe, only: %i[edit update]

  def index
    if params[:query].present?
      @recipes_results = policy_scope(Recipe).filter_recipes(params[:query])
    else
      @recipes = policy_scope(Recipe)
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'recipes/content.html.erb', locals: { recipes: @recipes } }
    end
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
    @recipe.ingredient_join_tables.build.build_ingredient
  end

  def show
    @recipe = Recipe.find(params[:id])
    authorize @recipe

    @user_recipes = Recipe.where(user_id: @recipe.user)
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
    authorize @recipe
    @recipe.ingredient_join_tables.build.build_ingredient if @recipe.ingredient_join_tables.empty?
  end

  def update
    authorize @recipe
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "Recipe updated successfully."
    else
      render :edit
    end
  end

  def my_recipes
    @recipes = policy_scope(Recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :meal_type,
                                  :season, :dietary_requirements, :cuisine, :prep_time,
                                  :total_time, :difficulty, :servings, :directions,
                                  images: [],
                                  ingredient_join_tables_attributes: [:id, :_destroy, ingredient_attributes: [:id, :name]])
  end
end
