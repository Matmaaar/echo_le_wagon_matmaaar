import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    console.log("✅ quiz-loader connected")
  }

  generateQuestions() {
    questions = this.element.getElementById("quizz_container")
    this.element.innerHTML = "<turbo-frame id='quizz_container'>⏳ Génération de 10 questions en cours...</turbo-frame>"
  }
}
