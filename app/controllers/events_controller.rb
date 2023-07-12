class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_event, only: %i[edit update show destroy trigger_api]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @events = policy_scope(Event)

    if params[:q].present?
      @events = @events.search(params[:q])
    end

    if params[:date].present?
      @events = @events.filter_by_date(params[:date])
    end
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
    @event = Event.find(params[:id])
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
      redirect_to events_path, alert: 'Event successfully deleted!'
    else
      redirect_to event_path(@event), alert: 'Event cannot be deleted!'
    end
  end

  def destroy_room_url
    @event = Event.find(params[:id])
    authorize @event
    room_url = @event.room_url

    if room_url.present? && room_url.destroy
      redirect_to event_path(@event), alert: 'Room URL successfully deleted!'
    else
      redirect_to event_path(@event), alert: 'Room URL cannot be deleted!'
    end
  end

  def trigger_api
    authorize @event
    event_title = @event.title.gsub(' ', '-')

    curl_command = <<-CMD.strip_heredoc
      curl -H "Content-Type: application/json" \
      -H "Authorization: Bearer 6d1a1e406e946e2404377bd21f1d2d70c80b386f8750f8244efa3c587718b5dc" \
      -X POST -d '{
        "name": "#{event_title}",
        "privacy": "public",
        "properties": {
           "start_audio_off": true,
           "start_video_off": true,
           "enable_chat": true
        }
      }' \
      https://api.daily.co/v1/rooms/
    CMD

    response = `#{curl_command}`

    if $?.success?
      room_data = JSON.parse(response)
      room_url = room_data['url']

      @event.create_or_update_room_url(room_url)

      flash[:notice] = 'Room successfully created!'
    else
      flash[:alert] = 'Failed to trigger API'
    end

    redirect_to event_path(@event)
  end

  def room_url
    @event = Event.find(params[:id])
    authorize @event

    room_url_record = RoomUrl.find_by(event_id: @event.id)

    if room_url_record.present?
      room_url = room_url_record.url

      redirect_to room_url, target: '_blank', allow_other_host: true
    else
      head :no_content
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :time, :paid, :recipe_id, photos: [])
  end

  def get_event
    @event = Event.find(params[:id])
  end
end
