// app/javascript/controllers/task_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["status"]

  updateStatus(e) {
    const newStatus = e.target.dataset.status
    fetch(this.data.get("url"), {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ task: { status: newStatus } })
    })
  }
}