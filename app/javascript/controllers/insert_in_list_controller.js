import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
static targets = ["items", "form"]

  connect() {
  }

  send(event){
    event.preventDefault();

    fetch(this.formTarget.action , {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
    })

  }
}
