import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section"]

  toggle(event) {
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
}
