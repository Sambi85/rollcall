import { Controller } from "@hotwired/stimulus"
import EmblaCarousel from "embla-carousel"

export default class extends Controller {
  static targets = ["viewport"]

  connect() {
    this.embla = EmblaCarousel(this.viewportTarget, {
      loop: true,
      dragFree: true,
      containScroll: "trimSnaps",
    })

    this.addRightClickDrag()
  }

  addRightClickDrag() {
    let isDragging = false
    let startX = 0
    let startScroll = 0

    this.viewportTarget.addEventListener("mousedown", (e) => {
      if (e.button !== 2) return
      e.preventDefault()
      isDragging = true
      startX = e.clientX
      startScroll = this.embla.scrollProgress() // get current scroll
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

    this.viewportTarget.addEventListener("contextmenu", (e) => {
      e.preventDefault()
    })
  }
}
