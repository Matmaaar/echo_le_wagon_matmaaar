import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages"]


  connect() {
    console.log('controller chat connected');
    this.scrollToBottom();
  }
  // initialize() {
  //   this.element.addEventListener("turbo:before-stream-render", this.#scrollToBottom.bind(this));
  // }

  scrollToBottom() {
    console.log('scroll to bottom called');
    const chatContainer = document.querySelector(".chat-container");
    if (chatContainer) {
      chatContainer.scrollTop = chatContainer.scrollHeight;
    }
  }
}
