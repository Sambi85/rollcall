import { Controller } from "@hotwired/stimulus"
import EmblaCarousel from "embla-carousel"

export default class extends Controller {
  static targets = ["viewport", "card"]
  static values = { currentId: Number }

  connect() {
    // Initialize Embla
    this.embla = EmblaCarousel(this.viewportTarget, {
      loop: true,
      dragFree: true,
      containScroll: "trimSnaps",
    })

    // Setup drag state
    this.dragging = false
    this.addRightClickDrag()

    // Scroll to current turn card and highlight it
    this.scrollToCurrentTurn()

    // Listen for card:selected events to update stats
    this.element.addEventListener("card:selected", (e) => {
      const selectedId = e.detail.selectedId

      // Find DOM elements to update
      const roundDiv = document.querySelector("#current-round")
      const statsDiv = document.querySelector("#creature-stats")

      const selectedCard = this.cardTargets.find(c => parseInt(c.dataset.cardId) === selectedId)
      if (!selectedCard) return

      const name = selectedCard.querySelector("h3").innerText
      const initiative = selectedCard.querySelector("p")?.innerText.split(": ")[1] || "Unknown"

      // Update "Current Round" section
      if (roundDiv) roundDiv.querySelector("strong").innerText = name

      // Update creature stats section
      if (statsDiv) {
        statsDiv.querySelector("h3").innerText = name
        const initiativeDiv = statsDiv.querySelector(".initiative p")
        if (initiativeDiv) initiativeDiv.innerText = initiative
      }

      // Update card borders and background colors
      this.cardTargets.forEach(card => {
        const id = parseInt(card.dataset.cardId)
        card.classList.remove("border-2", "border-white")
        if (id === selectedId) card.classList.add("border-2", "border-white")

        if (id === this.currentIdValue) {
          card.classList.add("bg-red-800", "text-white")
        } else if (id !== selectedId) {
          card.classList.remove("bg-red-800", "text-white")
        }
      })
    })
  }

  // --- Drag-safe click handling ---
  startDragCard(event) {
    this.dragging = false
    this.startX = event.clientX
    this.startY = event.clientY
  }

  moveDragCard(event) {
    const dx = Math.abs(event.clientX - this.startX)
    const dy = Math.abs(event.clientY - this.startY)
    if (dx > 5 || dy > 5) this.dragging = true
  }

  selectCard(event) {
    if (this.dragging) return
  
    const card = event.currentTarget
    const cardId = parseInt(card.dataset.cardId)
  
    this.highlightCard(cardId)
    this.updateStats(card)
    this.updateHpTracker(card)
  }
  


  highlightCard(cardId) {
    this.cardTargets.forEach(card => {
      const id = parseInt(card.dataset.cardId)

      // Add border to selected card
      if (id === cardId) {
        card.classList.add("border-2", "border-white")
      } else {
        card.classList.remove("border-2", "border-white")
      }

      // Keep current turn red
      if (id === this.currentIdValue) {
        card.classList.add("bg-red-800", "text-white")
      } else if (id !== cardId) {
        // Non-selected cards revert to gray
        card.classList.remove("bg-red-800", "text-white")
      }
    })
  }

  highlightCurrentStats(event) {
    const card = event.currentTarget
    const isCurrent = card.dataset.isCurrent === "true"
    const statsSection = document.getElementById("creature-stats")
  
    if (!statsSection) return
  
    if (isCurrent) {
      statsSection.classList.remove("bg-gray-900")
      statsSection.classList.add("bg-red-900")
    } else {
      statsSection.classList.remove("bg-red-900")
      statsSection.classList.add("bg-gray-900")
    }
  }  

  // --- Embla right-click drag support ---
  addRightClickDrag() {
    let isDragging = false
    let startX = 0
    let startScroll = 0

    this.viewportTarget.addEventListener("mousedown", (e) => {
      if (e.button !== 2) return
      e.preventDefault()
      isDragging = true
      startX = e.clientX
      startScroll = this.embla.scrollProgress()
    })

    window.addEventListener("mousemove", (e) => {
      if (!isDragging) return
      const delta = e.clientX - startX
      const containerWidth = this.viewportTarget.offsetWidth
      const moveProgress = -delta / containerWidth
      this.embla.scrollTo(startScroll + moveProgress)
    })

    window.addEventListener("mouseup", () => {
      isDragging = false
    })

    this.viewportTarget.addEventListener("contextmenu", (e) => e.preventDefault())
  }

  // --- Scroll carousel to current turn on load ---
  scrollToCurrentTurn() {
    const currentIndex = this.cardTargets.findIndex(
      card => parseInt(card.dataset.cardId) === this.currentIdValue
    )
    if (currentIndex !== -1) {
      this.embla.scrollTo(currentIndex)
      this.highlightCard(this.currentIdValue)
    }
  }

  updateHpTracker(card) {
    const trackerId = card.dataset.trackerId
    const creatureId = card.dataset.cardId
    const turboFrame = document.getElementById("hp_tracker")
    if (!turboFrame) return
  
    fetch(`/trackers/${trackerId}/creatures/${creatureId}/hp_controls`, {
      headers: { "Turbo-Frame": "hp_tracker" }
    })
    .then(resp => resp.text())
    .then(html => {
      turboFrame.innerHTML = html
    })
  }  

  updateStats(card) {
    const statsDiv = document.getElementById("creature-stats")
    if (!statsDiv) return
  
    // Update static stats (only once, won't change with HP edits)
    statsDiv.querySelector("h3").innerText = card.dataset.name
    statsDiv.querySelector(".stat-box.initiative .value").innerText = card.dataset.initiative
    statsDiv.querySelector(".stat-box.ac .value").innerText = card.dataset.ac
    statsDiv.querySelector(".stat-box.speed .value").innerText = card.dataset.speed
  
    // Update HP inside its Turbo Frame
    const hpFrame = document.getElementById(`creature_hp_${card.dataset.cardId}`)
    if (hpFrame) {
      hpFrame.innerHTML = `
        <div class="stat-box hp bg-gray-800 p-2 rounded-lg text-center">
          <p class="font-semibold">HP</p>
          <p class="value">${parseInt(card.dataset.hpCurrent) + parseInt(card.dataset.hpTemp)} / ${card.dataset.hpMax}</p>
        </div>
      `
    }    
  
    // Red highlight if this card is the current turn
    if (card.dataset.isCurrent === "true") {
      statsDiv.classList.add("bg-red-800")
      statsDiv.classList.remove("bg-gray-900")
    } else {
      statsDiv.classList.remove("bg-red-800")
      statsDiv.classList.add("bg-gray-900")
    }
  }  
  
}
