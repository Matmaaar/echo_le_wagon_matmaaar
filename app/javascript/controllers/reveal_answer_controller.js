import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["explanation", "nextButton", "retryButton"]

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
      this.retryButtonTarget.style.display = "none"  // Pas besoin de retry si bonne réponse
    } else {
      clickedButton.classList.add("wrong-answer")
      this.retryButtonTarget.style.display = "inline-block" // Afficher bouton retry si mauvaise réponse
    }

    // Afficher l’explication
    this.explanationTarget.style.display = "block"

    // Afficher toujours le bouton next question, quelle que soit la réponse
    this.nextButtonTarget.style.display = "inline-block"
  }

  nextQuestion() {
    // Trouve la question courante
    const currentIndex = parseInt(this.data.get("indexValue"))
    // Cache la question actuelle
    this.element.style.display = "none"
    // Trouve toutes les questions
    const allQuestions = document.querySelectorAll("[data-controller='reveal-answer']")
    // Affiche la suivante si elle existe
    if (allQuestions.length > currentIndex + 1) {
      allQuestions[currentIndex + 1].style.display = "block"
    }
  }

  retry() {
    // Réinitialise l’état des boutons et cache explication + boutons
    const allButtons = this.element.querySelectorAll(".answer-button")
    allButtons.forEach(button => {
      button.disabled = false
      button.classList.remove("disabled-answer", "correct-answer", "wrong-answer")
    })
    this.explanationTarget.style.display = "none"
    this.nextButtonTarget.style.display = "none"
    this.retryButtonTarget.style.display = "none"
  }
}
