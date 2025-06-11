import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { loaded: Boolean }
  connect() {console.log("NotesController connected")}
  
  toggle() {
    const container = document.getElementById("notes-container")
    
    if (this.loadedValue) {
      container.style.display = container.style.display === "none" ? "block" : "none"
    } 
  }
}