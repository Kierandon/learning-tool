import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "content"]
  
  connect() {
  }
  
    toggleSection(event) {
        const button = event.currentTarget
        const sectionId = button.dataset.sectionId
        const contentElement = document.getElementById(`section-${sectionId}-children`)
        const objectivesElement = document.getElementById(`objectives-${sectionId}`)
        const icon = button.querySelector('svg')
        
        if (contentElement && icon) {
            if (contentElement.classList.contains('hidden')) {
                contentElement.classList.remove('hidden')
                icon.classList.add('rotate-90')
            } else {
                contentElement.classList.add('hidden')
                icon.classList.remove('rotate-90')
                // Close learning objectives when section is closed
                if (objectivesElement) {
                    objectivesElement.classList.add('hidden')
                    const objectivesIcon = document.querySelector(`[data-section-id="${sectionId}"] .objectives-icon`)
                    if (objectivesIcon) {
                        objectivesIcon.classList.remove('rotate-180')
                    }
                }
            }
        }
        
        event.preventDefault()
    }

    toggleLearningObjectives(event) {
        const button = event.currentTarget
        const sectionId = button.dataset.sectionId
        const objectivesElement = document.getElementById(`objectives-${sectionId}`)
        const icon = button.querySelector('svg')
        
        if (objectivesElement && icon) {
            if (objectivesElement.classList.contains('hidden')) {
                objectivesElement.classList.remove('hidden')
                icon.classList.add('rotate-180')
            } else {
                objectivesElement.classList.add('hidden')
                icon.classList.remove('rotate-180')
            }
        }
        
        event.preventDefault()
    }
}
