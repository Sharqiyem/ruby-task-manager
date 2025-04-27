import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = {
        message: { type: String, default: "Are you sure? This action cannot be undone." }
    }

    connect() {
        console.log("Confirmation controller connected")
    }

    beforeSubmit(event) {
        console.log("Confirmation triggered")
        if (!confirm("Are you sure you want to delete this task?")) {
            event.preventDefault()
            event.stopPropagation()
        }
    }

    confirm(event) {
        console.log("Confirmation requested")
        if (!window.confirm(this.messageValue)) {
            event.preventDefault()
            event.stopPropagation()
        }
    }
}