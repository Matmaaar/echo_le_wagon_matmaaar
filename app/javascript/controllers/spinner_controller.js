import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    console.log("test")
  }
  toggleTag() {
    this.buttonTarget.classList.toggle('small-round-button')
    this.buttonTarget.classList.toggle('small-round-button-green')
  }
}
