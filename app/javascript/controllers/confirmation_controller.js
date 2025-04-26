import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.element.addEventListener("submit", (event) => {
            if (!confirm("Are you sure you want to delete this task? This action cannot be undone.")) {
                event.preventDefault()
            }
        })
    }
}