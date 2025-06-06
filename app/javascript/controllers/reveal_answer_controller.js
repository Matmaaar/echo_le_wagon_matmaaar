import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["explanation"]

  select(event) {
    const clickedButton = event.currentTarget
    const selectedAnswer = clickedButton.innerText.trim()
    const correctAnswer = clickedButton.dataset.correctAnswer.trim()

    const allButtons = this.element.querySelectorAll(".answer-button")

    // Désactiver tous les boutons
    allButtons.forEach(button => {
      button.disabled = true
      button.classList.add("disabled-answer")
    })

    if (selectedAnswer === correctAnswer) {
      clickedButton.classList.add("correct-answer")
    } else {
      clickedButton.classList.add("wrong-answer")
    }

    // Afficher l’explication
    this.explanationTarget.style.display = "block"
  }
}
