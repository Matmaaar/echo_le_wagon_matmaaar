import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "button"]

  showInput() {
    this.buttonTarget.classList.add("d-none")
    this.inputTarget.classList.remove("d-none")
    this.inputTarget.focus()
  }
}