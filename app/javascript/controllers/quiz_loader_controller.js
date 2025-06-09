import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    console.log("✅ quiz-loader connected")
    console.log("🔗 URL:", this.urlValue)
    this.container = this.element.querySelector("#quiz-container")
  }

  generateQuestions() {
    this.element.innerHTML = "<p id='quizz_container'>⏳ Génération de 10 questions en cours...</p>"
  }
}
