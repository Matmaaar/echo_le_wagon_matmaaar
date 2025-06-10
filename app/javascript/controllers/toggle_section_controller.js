import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section", "button"]

  toggle(event) {
    console.log(event.currentTarget)
    const targetId = event.currentTarget.dataset.targetId
    const targetSection = this.sectionTargets.find(section => section.id === targetId)
    if (!targetSection) return

    // Pour afficher ou non la section
    if (targetSection.style.display === "block") return

    // On cache toutes les sections
    this.sectionTargets.forEach(section => {
      section.style.display = "none"
    })

    // Afficher uniquement la bonne section
    targetSection.style.display = "block"

    // Pour enlever les class
    this.buttonTargets.forEach(btn => btn.classList.remove("btn-active"))
    // Pour ajouter la classe css active (bouton blanc)

    event.currentTarget.classList.add("btn-active")
  }

  hide(event) {
    const targetId = event.currentTarget.dataset.targetId
    const targetSection = this.sectionTargets.find(section => section.id === targetId)
    if (!targetSection) return
    targetSection.style.display = "none"
  }
}
