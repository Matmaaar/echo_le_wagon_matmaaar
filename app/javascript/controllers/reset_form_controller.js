import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  reset() {
    console.log(this.element)
    this.element.reset()
  }

  connect() {
    console.log("ResetFormController connected")
  }
}
