import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["spinner"]

  connect() {
    console.log("spinner_controller.js")
  }
  toggle_show() {
    this.spinnerTarget.classList.toggle("hidden")
  }

}
