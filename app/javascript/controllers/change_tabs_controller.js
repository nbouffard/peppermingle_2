import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-tabs"
export default class extends Controller {
  static targets = ["url", 'content']
  connect() {
  }

  active(event){
    event.preventDefault();
    // console.log(event);
    const url = event.currentTarget.getAttribute('href')
    // console.log(url)
    fetch(url, { headers: { 'Accept' : 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      console.log(this.urlTargets);
      this.contentTarget.innerHTML = data;
      const oldActiveTab = this.urlTargets.find(element => element.classList.contains('active'));
      const newActiveTab = event.target;
      oldActiveTab.classList.remove('active');
      newActiveTab.classList.add('active');
    })
  }
}
