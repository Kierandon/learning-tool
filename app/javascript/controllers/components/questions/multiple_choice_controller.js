import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["option", "input", "checkbox", "radio"]
  static values = { 
    multiple: Boolean,
    answered: Boolean
  }

  connect() {
    if (this.answeredValue) return
    this.selectedValues = new Set()
  }

  select(event) {
    if (this.answeredValue) return
    
    const option = event.currentTarget
    const value = option.dataset.value
    
    if (this.multipleValue) {
      this.handleMultipleSelection(value, option)
    } else {
      this.handleSingleSelection(value, option)
    }
    
    this.updateInput()
  }

  handleMultipleSelection(value, option) {
    if (this.selectedValues.has(value)) {
      this.selectedValues.delete(value)
      option.classList.remove('selected')
      this.checkboxTargets[this.optionTargets.indexOf(option)].classList.remove('bg-indigo-600')
    } else {
      this.selectedValues.add(value)
      option.classList.add('selected')
      this.checkboxTargets[this.optionTargets.indexOf(option)].classList.add('bg-indigo-600')
    }
  }

  handleSingleSelection(value, option) {
    this.selectedValues.clear()
    this.selectedValues.add(value)
    
    this.optionTargets.forEach((opt, index) => {
      opt.classList.remove('selected')
      this.radioTargets[index].classList.remove('bg-indigo-600')
    })
    
    option.classList.add('selected')
    this.radioTargets[this.optionTargets.indexOf(option)].classList.add('bg-indigo-600')
  }

  updateInput() {
    this.inputTarget.value = Array.from(this.selectedValues)
  }
}
