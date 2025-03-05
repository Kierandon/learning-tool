import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.scrollToTop()
  }

  scrollToTop() {
    console.log("Scrolled!")
    window.scrollTo({ top: 0, behavior: 'instant' })
  }
}
