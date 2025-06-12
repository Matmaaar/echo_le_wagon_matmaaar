import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  reset() {
    console.log(this.element)
    this.element.reset()
    const emptyMessage = document.getElementById("text-no-messages")
    if (emptyMessage)  // Check if the element exists before trying to remove it
    {
      emptyMessage.remove()
    }
  }

  connect() {
    console.log("ResetFormController connected")
    console.log(document.getElementById("text-no-messages"))
  }
}
