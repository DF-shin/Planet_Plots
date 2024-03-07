import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
static targets = ["items", "form", "dNone"]

  connect() {
  }

  display() {
    this.dNoneTarget.classList.toggle("d-none");
  }

  send(event){
    event.preventDefault();

    fetch(this.formTarget.action , {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then((response) => {
      console.log(response)
      if (response.status === 204) {
        this.display()
      }
    })

  }
}
