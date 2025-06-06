import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    console.log("✅ quiz-loader connected")
    this.container = this.element.querySelector("#quiz-container")
  }

  generateQuestion() {
    this.container.innerHTML = "<p>⏳ Chargement de la question...</p>"

    //fetch(this.urlValue, {
    //  method: "POST",
    //  headers: {
    //    "Accept": "application/json",
    //    "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
    //  }
    //})
    //  .then(res => res.json())
    //  .then(data => {
    //    this.displayQuestion(data.question)
    //  })
    //  .catch(err => {
    //    this.container.innerHTML = `<p>❌ Erreur : ${err.message}</p>`
    //    console.error(err)
    //  })
  }

  displayQuestion(data) {
    this.container.innerHTML = `
      <div class="question-block" style="margin-bottom: 30px;">
        <p><strong>${data.statement}</strong></p>
        ${data.answers.map(answer => `
          <button class="btn btn-outline-primary mb-2 answer-button" data-correct="${data.correct}">
            ${answer}
          </button>
        `).join("")}
        <p class="explanation" style="display: none; margin-top: 10px;">
          ✅ <strong>Explication :</strong> ${data.explanation}
        </p>
      </div>
    `

    this.container.querySelectorAll(".answer-button").forEach(btn => {
      btn.addEventListener("click", (e) => {
        const isCorrect = e.target.innerText.trim() === data.correct
        const explanation = this.container.querySelector(".explanation")

        if (isCorrect) {
          e.target.classList.remove("btn-outline-primary")
          e.target.classList.add("btn-success")
          explanation.style.display = "block"
        } else {
          e.target.classList.remove("btn-outline-primary")
          e.target.classList.add("btn-danger")
        }
      })
    })
  }
}