class BookingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @event = Event.find(params[:event_id])
    @booking = @event.bookings.build(booking_params)
    @booking.user = current_user
    authorize @booking

    if @booking.save
      redirect_to @event, notice: 'Booking was successful!'
    else
      error_message = @booking.errors.full_messages.join(', ')
      puts "Booking failed: #{error_message}"
      redirect_to @event, alert: 'Booking failed!'
    end
  end

  def my_bookings
    @bookings = current_user.bookings
    authorize Booking

    respond_to do |format|
      format.html
      format.text { render partial: 'booking_content.html', locals: { bookings: @bookings } }
    end
  end

  def destroy
    @booking = Booking.find(params[:id]) # Load the booking record
    authorize @booking

    if @booking
      if @booking.destroy
        flash[:notice] = "Booking cancelled successfully."
      else
        flash[:error] = "An error occurred while cancelling the booking."
      end
    end

    redirect_to my_bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:event_id)
  end
end
