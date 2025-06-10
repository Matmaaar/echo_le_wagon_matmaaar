import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["answerButton", "explanation"]
  static values = { correctAnswer: String }

  connect() {
    console.log("Quizz controller connected")
    console.log("Correct answer value:", this.correctAnswerValue)
    console.log("Answer button targets:", this.answerButtonTargets)
    console.log("explanation targets:", this.answerButtonTargets)
  }
  selectAnswer(event) {
     event.preventDefault()

      this.answerButtonTargets.forEach(button => {
      button.disabled = true

      this.explanationTarget.classList.remove("d-none")

      const isCorrect = button.value === this.correctAnswerValue;
      const isSelected = button === event.currentTarget;

      if (isCorrect) {
        button.classList.add("correct-answer");
      }

      if (isSelected && !isCorrect) {
        button.classList.add("wrong-answer");
      }
    })





  }
}
