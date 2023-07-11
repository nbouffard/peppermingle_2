import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const isBooked = this.isAlreadyBooked();
    if (isBooked) {
      this.setBookedState();
    }
  }

  bookEvent() {
    const eventId = this.element.getAttribute('data-event-id');
    const userId = this.element.getAttribute('data-user-id');

    if (this.isAlreadyBooked()) {
      console.log('Already booked!');
      return;
    }

    fetch(`/events/${eventId}/bookings`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ event_id: eventId, user_id: userId })
    })
      .then(response => {
        if (response.ok) {
          if (response.redirected) {
            this.setBookedState();
          } else {
            throw new Error('Booking failed');
          }
        } else {
          throw new Error(`Booking failed with status ${response.status}`);
        }
      })
      .catch(error => {
        console.error('An error occurred while booking the event.', error);
      });
  }

destroyBooking(event) {
  event.preventDefault(); // Prevent the default behavior of the button click

  const bookingId = this.element.getAttribute('data-booking-id');

  console.log('Booking ID:', bookingId);

  const confirmed = confirm('Are you sure you want to cancel this booking?');
  if (!confirmed) {
    return;
  }

  fetch(`/bookings/${bookingId}`, {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    }
  })
    .then(response => {
      if (response.ok) {
        this.setUnbookedState();
        this.element.remove(); // Remove the booking element from the DOM
      } else {
        throw new Error(`Booking deletion failed with status ${response.status}`);
      }
    })
    .catch(error => {
      console.error('An error occurred while deleting the booking.', error);
    });
}


  setBookedState() {
    this.element.disabled = true;
    this.element.textContent = 'Attending';
  }

  setUnbookedState() {
    this.element.disabled = false;
    this.element.textContent = 'Sign Up';
  }

  isAlreadyBooked() {
    return this.element.dataset.isBooked === 'true';
  }
}
