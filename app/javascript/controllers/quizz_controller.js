import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["answerButton", "explanation"]
  static values = {
                    correctAnswer: String ,
                    url: String,
                    validated: Boolean
                  }


  connect() {
    console.log("Quizz controller connected")
    console.log("Correct answer value:", this.validatedValue);


  }


  // showFinalState() {
  //   // Désactiver tous les boutons
  //   this.answerButtonTargets.forEach(button => {
  //     button.disabled = true

  //     // Montrer la bonne réponse
  //     if (button.value === this.correctAnswerValue) {
  //       button.classList.add("correct-answer")
  //     }
  //   })

  //   // Montrer l'explication
  //   this.explanationTarget.classList.remove("d-none")
  // }


  selectAnswer(event) {
     event.preventDefault()

    //   if (this.validatedValue) {
    //   return // Ne fait rien si déjà validé
    // }


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

      const isJust = event.currentTarget.value === this.correctAnswerValue;

    if (isJust) {
        console.log("Correct answer selected and fetch launched");
        fetch(this.urlValue, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
          },
          body: JSON.stringify({question: {validated: true}

          })}
        )
      }




  }
}
