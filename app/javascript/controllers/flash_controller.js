import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static values = {
    timeout: { type: Number, default: 3000 }
  }

  connect() {
    setTimeout(() => {
      this.element.classList.add("hidden");
      setTimeout(() => this.element.remove(), 500); // attend la transition CSS
    }, this.timeoutValue);
  }
}
