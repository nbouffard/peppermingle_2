class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :show, status: :unproccessable_entity
    end
  end

  def my_recipes_events_bookings
    case params[:query]
    when 'recipes'
      @recipes = policy_scope(Recipe)
      respond_to do |format|
        format.html
        format.text { render partial: 'recipes/content', locals: { recipes: @recipes }, formats: [:html] }
      end
    when 'events'
      @events = policy_scope(Event)
      respond_to do |format|
        format.html
        format.text { render partial: 'events/event_content', locals: { events: @events }, formats: [:html] }
      end
    when 'bookings'
      @bookings = policy_scope(Booking)
      respond_to do |format|
        format.html
        format.text { render partial: 'bookings/booking_content', locals: { bookings: @bookings }, formats: [:html] }
      end
    end
    # if params[:query] == 'recipes'
    #   @recipes = policy_scope(Recipe)

    #   respond_to do |format|
    #     format.html
    #     format.text { render partial: 'recipes/content', locals: { recipes: @recipes }, formats: [:html] }
    #   end
    #   elsif params[:query] == 'events'
    #     @events = policy_scope(Event)
    #     respond_to do |format|
    #       format.html
    #       format.text { render partial: 'events/event_content', locals: { events: @events }, formats: [:html] }
    #     end
    #   elsif params[:query] == 'bookings'
    #     @bookings = policy_scope(Booking)
    #     respond_to do |format|
    #       format.html
    #       format.text { render partial: 'bookings/booking_content', locals: { bookings: @bookings }, formats: [:html] }
    #     end
    # end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :location, :bio, :speciality, :photo, :user_name)
  end
end
