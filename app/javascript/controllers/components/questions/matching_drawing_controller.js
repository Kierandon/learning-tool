import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["term", "definition", "canvas", "input"]
  
  connect() {
    this.canvas = this.canvasTarget
    this.ctx = this.canvas.getContext('2d')
    this.connections = new Map()
    this.selectedTerm = null
    this.colors = [
      '#2563EB', // blue
      '#DC2626', // red
      '#059669', // green
      '#7C3AED', // purple
      '#EA580C', // orange
      '#0891B2', // cyan
      '#4F46E5', // indigo
      '#DB2777', // pink
    ]
    this.usedColors = new Set()
    
    this.resizeCanvas()
    window.addEventListener('resize', () => this.resizeCanvas())
    
    // Reset all styles initially
    this.resetStyles()
  }

  resizeCanvas() {
    const rect = this.canvas.getBoundingClientRect()
    this.canvas.width = rect.width
    this.canvas.height = rect.height
    this.drawConnections()
  }

  resetStyles() {
    // Only reset unmatched terms and definitions
    this.termTargets.forEach(term => {
      if (!this.connections.has(term.dataset.termId)) {
        term.classList.remove('ring-2', 'ring-offset-2')
        term.style.borderColor = ''
        term.style.backgroundColor = ''
      }
    })
    
    this.definitionTargets.forEach(def => {
      if (!Array.from(this.connections.values()).some(conn => conn.definitionId === def.dataset.definitionId)) {
        def.classList.remove('ring-2', 'ring-offset-2')
        def.style.borderColor = ''
        def.style.backgroundColor = ''
      }
    })
  }

  getNextColor() {
    const availableColors = this.colors.filter(color => !this.usedColors.has(color))
    if (availableColors.length === 0) {
      this.usedColors.clear() // Reset if all colors are used
      return this.colors[0]
    }
    const color = availableColors[0]
    this.usedColors.add(color)
    return color
  }

  selectTerm(event) {
    event.preventDefault()
    const term = event.currentTarget
    
    // Reset only unmatched items
    this.resetStyles()
    
    // Allow reselection of already matched terms
    if (this.connections.has(term.dataset.termId)) {
      // Remove existing connection
      this.connections.delete(term.dataset.termId)
      // Reset the corresponding input
      this.inputTargets.forEach(input => {
        if (input.dataset.termId === term.dataset.termId) {
          input.value = ''
        }
      })
      this.drawConnections()
    }
    
    // Highlight selected term
    this.selectedTerm = term
    term.classList.add('ring-2', 'ring-offset-2')
    term.style.borderColor = '#6B7280' // gray-500
    term.style.backgroundColor = '#F3F4F6' // gray-100
  }

  selectDefinition(event) {
    event.preventDefault()
    const definition = event.currentTarget
    
    // If no term is selected, do nothing
    if (!this.selectedTerm) return
    
    const termId = this.selectedTerm.dataset.termId
    const definitionId = definition.dataset.definitionId
    
    // If this definition is already matched, remove its existing connection
    for (const [existingTermId, connection] of this.connections.entries()) {
      if (connection.definitionId === definitionId) {
        this.connections.delete(existingTermId)
        // Reset the corresponding input
        this.inputTargets.forEach(input => {
          if (input.dataset.termId === existingTermId) {
            input.value = ''
          }
        })
      }
    }
    
    const color = this.getNextColor()
    
    // Store the new connection
    this.connections.set(termId, {
      definitionId: definitionId,
      color: color
    })
    
    // Update hidden input
    this.inputTargets.forEach(input => {
      if (input.dataset.termId === termId) {
        input.value = definitionId
      }
    })
    
    // Style the matched pair
    this.selectedTerm.style.borderColor = color
    this.selectedTerm.style.backgroundColor = `${color}10`
    definition.style.borderColor = color
    definition.style.backgroundColor = `${color}10`
    
    // Remove selection highlighting
    this.selectedTerm.classList.remove('ring-2', 'ring-offset-2')
    
    // Reset selection
    this.selectedTerm = null
    
    // Redraw connections
    this.drawConnections()
  }

  drawConnections() {
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
    
    // Draw all connections
    this.connections.forEach((connection, termId) => {
      this.drawConnection(termId, connection.definitionId, connection.color)
    })
  }

  drawConnection(termId, definitionId, color) {
    const term = this.termTargets.find(t => t.dataset.termId === termId)
    const definition = this.definitionTargets.find(d => d.dataset.definitionId === definitionId)
    
    if (term && definition) {
      const termRect = term.getBoundingClientRect()
      const defRect = definition.getBoundingClientRect()
      const canvasRect = this.canvas.getBoundingClientRect()
      
      // Calculate control points for curved line
      const startX = termRect.right - canvasRect.left
      const startY = termRect.top + termRect.height/2 - canvasRect.top
      const endX = defRect.left - canvasRect.left
      const endY = defRect.top + defRect.height/2 - canvasRect.top
      const controlX = startX + (endX - startX) / 2
      
      // Draw curved connection
      this.ctx.beginPath()
      this.ctx.moveTo(startX, startY)
      this.ctx.bezierCurveTo(controlX, startY, controlX, endY, endX, endY)
      this.ctx.strokeStyle = color
      this.ctx.lineWidth = 2
      this.ctx.stroke()
    }
  }
}
