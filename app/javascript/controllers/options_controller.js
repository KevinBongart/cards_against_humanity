import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["link", "list"]


  toggle() {
    event.preventDefault()

    var showClass    = "show"
    var expandText   = "Click here for additional options"
    var collapseText = "Hide options"

    if (this.listTarget.classList.contains(showClass)) {
      this.linkTarget.innerHTML = expandText
      this.listTarget.classList.remove(showClass)
    } else {
      this.linkTarget.innerHTML = collapseText
      this.listTarget.classList.add(showClass)
    }
  }
}
