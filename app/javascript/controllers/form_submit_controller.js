import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submit"
export default class extends Controller {
  static targets = ["submit"]

  connect() {
    console.log("form-submit-controller")
  }

  disable(event) {
    console.log("disable")
    this.submitTarget.disabled = true
  }

  showModal(event) {
    console.log("showModal")
    const modalFrame = document.getElementById("modal")
    modalFrame.innerHTML = `
      <div class="modal fade show" style="display:block;" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content bg-transparent border-0">
            <div class="modal-body text-center">
              <div class="spinner-border text-primary" role="status" style="width:3rem;height:3rem;">
                <span class="visually-hidden">Loading...</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    `
    const bsModal = new window.bootstrap.Modal(modalFrame.querySelector(".modal"))
    bsModal.show()
  }
}
