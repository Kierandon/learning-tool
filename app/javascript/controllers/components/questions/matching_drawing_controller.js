import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["term", "definition", "canvas", "input"]
  static values = {
    answered: Boolean
  }
  
  connect() {
    console.log('MatchingDrawingController connected')
    console.log(this.answeredValue)
    this.canvas = this.canvasTarget
    this.ctx = this.canvas.getContext('2d')
    this.connections = new Map()
    this.selectedTerm = null
    this.colorMap = new Map() // Map to store term-color associations
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
    this.colorIndex = 0
    
    this.resizeCanvas()
    // Use throttled resize to prevent excessive redraws
    let resizeTimeout
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimeout)
      resizeTimeout = setTimeout(() => this.resizeCanvas(), 100)
    })
    
    this.resetStyles()

    if (this.answeredValue) {
      this.disableInteractions()
    }
  }

  disableInteractions() {
    // Remove hover and click effects
    this.termTargets.forEach(term => {
      term.style.cursor = 'default'
      term.classList.remove('hover:shadow-md')
      term.classList.remove('cursor-pointer')
      // Remove click handlers
      term.removeAttribute('data-action')
    })
    
    this.definitionTargets.forEach(def => {
      def.style.cursor = 'default'
      def.classList.remove('hover:shadow-md')
      def.classList.remove('cursor-pointer')
      // Remove click handlers
      def.removeAttribute('data-action')
    })
    
    // Disable select elements if using dropdown style
    this.element.querySelectorAll('select').forEach(select => {
      select.disabled = true
    })
  }

  resizeCanvas() {
    const rect = this.element.getBoundingClientRect()
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

  getColorForTerm(termId) {
    // If the term already has a color assigned, return it
    if (this.colorMap.has(termId)) {
      return this.colorMap.get(termId)
    }
    
    // Otherwise, assign a new color
    const color = this.colors[this.colorIndex % this.colors.length]
    this.colorIndex++
    this.colorMap.set(termId, color)
    return color
  }

  selectTerm(event) {
    if (this.answeredValue) return
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
    if (this.answeredValue) return
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
    
    // Get deterministic color for this term
    const color = this.getColorForTerm(termId)
    
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
      // Get positions relative to the canvas
      const canvasRect = this.canvas.getBoundingClientRect()
      const termRect = term.getBoundingClientRect()
      const defRect = definition.getBoundingClientRect()
      
      // Calculate positions adjusted to canvas coordinates
      const startX = termRect.right - canvasRect.left
      const startY = termRect.top + termRect.height/2 - canvasRect.top
      const endX = defRect.left - canvasRect.left
      const endY = defRect.top + defRect.height/2 - canvasRect.top
      
      // Calculate control points for curved line with more curvature
      const midX = (startX + endX) / 2
      const curveOffset = Math.min(Math.abs(endX - startX) * 0.3, 100)
      
      // Draw curved connection
      this.ctx.beginPath()
      this.ctx.moveTo(startX, startY)
      this.ctx.bezierCurveTo(
        midX + curveOffset, startY, 
        midX - curveOffset, endY, 
        endX, endY
      )
      this.ctx.strokeStyle = color
      this.ctx.lineWidth = 2.5 // Slightly thicker line for better visibility
      this.ctx.stroke()
    }
  }
}
