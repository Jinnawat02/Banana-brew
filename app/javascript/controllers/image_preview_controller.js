import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    this.savedSrc = this.previewTarget.getAttribute("src")
  }

  disconnect() {
    this.revokeObjectUrl()
  }

  show() {
    this.revokeObjectUrl()
    const file = this.inputTarget.files[0]

    if (file) {
      this.objectUrl = URL.createObjectURL(file)
      this.display(this.objectUrl)
    } else if (this.savedSrc) {
      this.display(this.savedSrc)
    } else {
      this.previewTarget.removeAttribute("src")
      this.previewTarget.hidden = true
    }
  }

  display(src) {
    this.previewTarget.src = src
    this.previewTarget.hidden = false
  }

  // Object URLs keep the file in memory until revoked
  revokeObjectUrl() {
    if (this.objectUrl) URL.revokeObjectURL(this.objectUrl)
    this.objectUrl = null
  }
}
