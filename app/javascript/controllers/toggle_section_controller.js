import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section", "button"]

  connect() {
    console.log(
    "toggle connected"
    );
    // Là je mets de base la class active au bouton summary car il s'affiche au chargement

  }

  toggle(event) {
    const targetId = event.currentTarget.dataset.targetId;


    const targetSection = this.sectionTargets.find(section => section.id === targetId);
    console.log(targetSection)
    if (!targetSection) return;
    this.sectionTargets.forEach((section) =>{
        section.classList.remove("d-none");
        section.classList.add("d-none");}
    )
    // Afficher uniquement la bonne section
    targetSection.classList.remove("d-none");

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
