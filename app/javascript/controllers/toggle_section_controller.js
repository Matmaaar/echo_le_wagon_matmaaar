import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section", "button"]

  connect() {
    // Ici tous les boutons prennent la classe .hidden
    this.sectionTargets.forEach(section => {
      if (section.id !== "summary-section") {
        section.classList.add("hidden");
      }
    });

    // Là je mets de base la class active au bouton summary car il s'affiche au chargement
    const summaryButton = document.getElementById('summary-button');
    if (summaryButton) {
      summaryButton.classList.add("btn-active");
    }
  }

  toggle(event) {
    const targetId = event.currentTarget.dataset.targetId;
    const targetSection = this.sectionTargets.find(section => section.id === targetId);
    if (!targetSection) return;

    // Pour afficher ou non la section
    if (!targetSection.classList.contains("hidden")) return;

    // On cache toutes les sections sauf la vidéo
    this.sectionTargets.forEach(section => {
      if (section.id !== "video-section") {
        section.classList.add("hidden");
      }
    });

    // Afficher uniquement la bonne section
    targetSection.classList.remove("hidden");

    // Ici on enlève toutes les classes
    this.buttonTargets.forEach(btn => btn.classList.remove("btn-active"));

    // Pour ajouter la classe css active (bouton blanc)
    event.currentTarget.classList.add("btn-active");
  }

  hide(event) {
    const targetId = event.currentTarget.dataset.targetId;
    const targetSection = this.sectionTargets.find(section => section.id === targetId);
    if (!targetSection) return;
    targetSection.classList.add("hidden");
  }
}
