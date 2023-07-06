import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.element.addEventListener("click", this.openPopUpWindow.bind(this));
  }

  disconnect() {
    this.element.removeEventListener("click", this.openPopUpWindow.bind(this));
  }

  openPopUpWindow(event) {
    event.preventDefault();

    const url = this.element.getAttribute("href");
    const windowOptions = "toolbar=no,scrollbars=yes,resizable=yes,width=800,height=600";

    const newWindow = window.open(url, "_blank", windowOptions);
    newWindow.focus();
  }
}
