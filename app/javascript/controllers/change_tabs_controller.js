import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-tabs"
export default class extends Controller {
  static targets = ["url", 'content']
  connect() {
  }
  active(event){
    event.preventDefault();
    // console.log(event.currentTarget.href);
    // console.log(event.currentTarget.getAttribute('href'));
    const url = event.currentTarget.href
    fetch(url, { headers: { 'Accept' : 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      console.log(data);
    })
  }
}
