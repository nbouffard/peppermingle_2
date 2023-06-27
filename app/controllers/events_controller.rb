class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_event, only: %i[edit update show destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @events = policy_scope(Event)
  end

  def edit
    authorize @event
  end

  def update
    authorize @event
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def show
    authorize @event
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    authorize @event

    if @event.save
      redirect_to event_path(@event), alert: 'Event successfully created!'
    else
      render :new, alert: 'Event cannot be created!'
    end
  end

  def destroy
    authorize @event

    if @event.destroy
      redirect_to events_path, alert: 'Event successfully deleted!' # change the route to index when there is an index
    else
      redirect_to event_path(@event), alert: 'Event cannot be deleted!'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :paid, :recipe_id)
  end

  def get_event
    @event = Event.find(params[:id])
  end
end
