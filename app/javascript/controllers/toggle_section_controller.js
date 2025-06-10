import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section"]
  connect() {
    // Initialiser toutes les sections à "none" sauf la première
  console.log("toggle_section_controller.js")
    }


  toggle(event) {
    console.log("toggle")
    const targetId = event.currentTarget.dataset.targetId
    const targetSection = this.sectionTargets.find(section => section.id === targetId)
    if (!targetSection) return

    // Si la section est déjà visible, ne rien faire
    if (targetSection.style.display === "block") return

    // Sinon, cacher toutes les sections
    this.sectionTargets.forEach(section => {
      section.style.display = "none"
    })

    // Afficher uniquement la section cible
    targetSection.style.display = "block"
  }
  hide(event) {
    const targetId = event.currentTarget.dataset.targetId
    const targetSection = this.sectionTargets.find(section => section.id === targetId)
    if (!targetSection) return
    targetSection.style.display = "none"
  }
}
