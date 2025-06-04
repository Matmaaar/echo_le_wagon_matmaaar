import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section"]

  toggle(event) {
    const targetId = event.currentTarget.dataset.targetId
    this.sectionTargets.forEach((section) => {
      section.style.display = (section.id === targetId && section.style.display === "none") ? "block" : "none"
    })
  }
}
