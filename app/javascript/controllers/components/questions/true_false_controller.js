import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["option", "input"]
  static values = {
    answered: Boolean
  }

  connect() {
    const currentValue = this.inputTarget.value
    if (currentValue) {
      this.selectOption(currentValue)
    }
    
    if (this.answeredValue) {
      this.disableOptions()
    }
  }

  select(event) {
    if (this.answeredValue) return
    
    const value = event.currentTarget.dataset.value
    this.selectOption(value)
  }

  selectOption(value) {
    this.optionTargets.forEach(option => {
      if (option.dataset.value === value) {
        option.classList.add('border-indigo-600', 'bg-indigo-50', 'ring-2', 'ring-indigo-600', 'ring-offset-2')
      } else {
        option.classList.remove('border-indigo-600', 'bg-indigo-50', 'ring-2', 'ring-indigo-600', 'ring-offset-2')
      }
    })
    this.inputTarget.value = value
    
    if (this.answeredValue) {
      this.disableOptions()
    }
  }

  disableOptions() {
    this.optionTargets.forEach(option => {
      option.classList.remove('cursor-pointer', 'hover:shadow-md')
      option.classList.add('pointer-events-none', 'opacity-75')
    })
  }
}
