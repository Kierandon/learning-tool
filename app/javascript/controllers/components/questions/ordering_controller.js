import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "slot", "itemPool", "orderSlots", "input"]
  static values = {
    answered: Boolean
  }

  connect() {
    console.log('Ordering controller connected')
    if (this.answeredValue) return
    
    this.selectedItem = null
    this.initializeClickHandlers()
    this.updateItemOrder()
  }

  initializeClickHandlers() {
    // Add click handlers to each item in the pool
    this.itemTargets.forEach(item => {
      item.addEventListener('click', () => this.selectItem(item))
    })

    // Add click handlers to each slot
    this.slotTargets.forEach(slot => {
      slot.addEventListener('click', () => this.placeItem(slot))
    })
  }

  selectItem(item) {
    // Check if the item is in a slot - if so, return it to the pool
    const slotContainer = item.closest('[data-components--questions--ordering-target="slot"]')
    if (slotContainer) {
      this.returnItemToPool(item, slotContainer)
      return
    }
    
    // Clear previous selection
    this.itemTargets.forEach(i => i.classList.remove('bg-blue-100', 'ring-2', 'ring-blue-500'))
    
    if (this.selectedItem === item) {
      // Deselect if clicking the same item
      this.selectedItem = null
    } else {
      // Select the new item
      item.classList.add('bg-blue-100', 'ring-2', 'ring-blue-500')
      this.selectedItem = item
    }
  }

  returnItemToPool(item, slot) {
    // Get the item ID
    const itemId = item.dataset.itemId
    
    // Find the original item in the pool and show it
    const originalItems = this.itemPoolTarget.querySelectorAll(`[data-item-id="${itemId}"]`)
    originalItems.forEach(originalItem => {
      originalItem.style.display = ''
    })
    
    // Clear the slot and restore placeholder
    const slotContent = slot.querySelector('.ml-10')
    slotContent.innerHTML = '<div class="text-gray-400 italic">Click to place selected item</div>'
    
    // Clear any selection
    this.selectedItem = null
    
    // Update the form data
    this.updateItemOrder()
  }

  placeItem(slot) {
    if (!this.selectedItem) return

    // Get existing item in slot (if any)
    const existingItem = slot.querySelector('[data-item-id]')
    const placeholderText = slot.querySelector('.text-gray-400')
    
    // Get source container (either itemPool or another slot)
    const sourceContainer = this.selectedItem.parentElement
    
    // Clone the item for placement
    const itemClone = this.selectedItem.cloneNode(true)
    itemClone.classList.remove('bg-blue-100', 'ring-2', 'ring-blue-500')
    itemClone.addEventListener('click', () => this.selectItem(itemClone))
    
    // Place the selected item in the slot
    if (existingItem) {
      // If there's already an item in this slot, replace it
      const oldItemId = existingItem.dataset.itemId
      const oldItems = this.itemPoolTarget.querySelectorAll(`[data-item-id="${oldItemId}"]`)
      oldItems.forEach(item => item.style.display = '')
      
      const slotContent = slot.querySelector('.ml-10')
      slotContent.innerHTML = ''
      slotContent.appendChild(itemClone)
    } else if (placeholderText) {
      // If there's just placeholder text, replace it
      const slotContent = slot.querySelector('.ml-10')
      slotContent.innerHTML = ''
      slotContent.appendChild(itemClone)
    } else {
      // Otherwise just append to the slot content area
      const slotContent = slot.querySelector('.ml-10')
      slotContent.appendChild(itemClone)
    }
    
    // Hide the original item if it was in the item pool
    if (sourceContainer === this.itemPoolTarget) {
      this.selectedItem.style.display = 'none'
    } 
    // If the item was in another slot, restore the placeholder text in that slot
    else if (sourceContainer.closest('[data-components--questions--ordering-target="slot"]')) {
      const oldSlot = sourceContainer.closest('[data-components--questions--ordering-target="slot"]')
      const oldSlotContent = oldSlot.querySelector('.ml-10')
      oldSlotContent.innerHTML = '<div class="text-gray-400 italic">Click to place selected item</div>'
    }
    
    // Clear selection
    this.selectedItem = null
    this.itemTargets.forEach(i => i.classList.remove('bg-blue-100', 'ring-2', 'ring-blue-500'))
    
    // Update the item order
    this.updateItemOrder()
  }

  updateItemOrder() {
    const values = this.slotTargets.map(slot => {
      const item = slot.querySelector('[data-item-id]');
      return item ? item.dataset.itemId : "";
    });
    
    this.inputTarget.value = JSON.stringify(values);
  }
  
}
