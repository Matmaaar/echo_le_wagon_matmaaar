import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  delete(event) {
    console.log("DELETE bouton cliqué");
    console.log("URL:", this.urlValue);

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const url = this.urlValue;

    if (confirm(event.target.dataset.turboConfirm)) {
      fetch(url, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': csrfToken,
          'Accept': 'text/html'
        }
      }).then(response => {
        if (response.ok) {
          window.location.href = '/contents';
        } else {
          console.error('Erreur:', response.status);
        }
      }).catch(error => {
        console.error('Erreur fetch:', error);
      });
    }
  }
}