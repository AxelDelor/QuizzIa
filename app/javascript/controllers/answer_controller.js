import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="answer"
export default class extends Controller {
  static targets = ["button", "textia"]

  connect() {
    console.log("coucou")
  }

  reveal(event) {
    event.preventDefault()
    event.target.classList.add("d-none")
    this.textiaTargets[this.buttonTargets.indexOf(event.target)].classList.remove("d-none")
  }
}
