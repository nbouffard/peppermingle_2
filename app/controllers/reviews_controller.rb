class ReviewsController < ApplicationController
  before_action :reviewable_object, only: %i[new create]

  def index
    @reviewable = Reviewable.find(params[:id])
    @reviews = @reviewable.reviews
  end

  def new
    @reviewable = reviewable_object
    @review = @reviewable.reviews.new
    authorize @review
  end

  def create
    @reviewable = reviewable_object
    @review = @reviewable.reviews.new(review_params)
    @review.user = current_user
    authorize @review

    if @review.save
      redirect_to @reviewable, notice: 'Review successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :suggestion, :reviewable_id)
  end

  def reviewable_object
    if params[:user_id]
      User.find(params[:user_id])
    elsif params[:recipe_id]
      Recipe.find(params[:recipe_id])
    end
  end
end
