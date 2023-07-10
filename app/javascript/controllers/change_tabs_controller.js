import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-tabs"
export default class extends Controller {
  static targets = ["url", 'content']
  connect() {
  }

  active(event){
    event.preventDefault();
    const url = event.currentTarget.getAttribute('href')
    fetch(url, { headers: { 'Accept' : 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      this.contentTarget.innerHTML = data;
      // this.currentTarget.classList.add('active-tab')
    })
  }
}
