import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["answerButton", "explanation"]

  connect() {
    console.log("Quizz controller connected")
  }

  selectAnswer(event) {
    const clickedButton = event.target
    const isCorrect = clickedButton.dataset.correct === "true"

    // Désactive tous les boutons et applique les couleurs
    this.answerButtonTargets.forEach(button => {
      button.disabled = true

      if (button.dataset.correct === "true") {
        button.classList.remove("btn-outline-primary")
        button.classList.add("btn-success") // Vert pour la bonne réponse
      } else {
        button.classList.remove("btn-outline-primary")
        button.classList.add("btn-danger") // Rouge pour les mauvaises réponses
      }
    })

    // Affiche l'explication
    this.explanationTarget.style.display = "block"
  }
}
