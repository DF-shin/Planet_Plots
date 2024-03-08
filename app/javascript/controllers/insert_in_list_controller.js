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
      if (response.status === 204) {
        this.display()
      }
    })

    const alert = document.querySelector(".js-alert")
    // console.log(alert);
    alert.removeAttribute("style")
    window.setTimeout(function() {
      $(".alert").fadeTo(1000, 0).slideUp(1000, function(){

      });
    }, 5000);

  }
}
