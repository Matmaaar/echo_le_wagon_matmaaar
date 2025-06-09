import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    console.log("✅ quiz-loader connected")
    this.container = this.element.querySelector("#quiz-container")
  }

  generateQuestions() {
    this.container.innerHTML = "<p>⏳ Génération de 10 questions en cours...</p>"

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      }
    })
      .catch(err => {
        this.container.innerHTML = `<p>❌ Erreur : ${err.message}</p>`
        console.error(err)
      })
  }
}
