import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
    static targets = ["column"]

    connect() {
        console.log("Sortable controller connected")
        this.initializeSortable()
    }

    initializeSortable() {
        console.log("Initializing sortable columns:", this.columnTargets.length)

        this.columnTargets.forEach(column => {
            new Sortable(column, {
                group: 'shared',
                animation: 150,
                ghostClass: 'sortable-ghost',
                onEnd: (event) => this.handleDragEnd(event)
            })
        })
    }

    handleDragEnd(event) {
        const taskId = event.item.dataset.taskId
        const newStatus = event.to.dataset.status

        console.log("Drag ended:", { taskId, newStatus })

        if (taskId && newStatus) {
            this.updateTaskStatus(taskId, newStatus, event.item)
        }
    }

    updateTaskStatus(taskId, newStatus, element) {
        element.style.opacity = '0.5'

        fetch(`/tasks/${taskId}/update_status`, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
            },
            body: JSON.stringify({ status: newStatus })
        })
            .then(response => response.json())
            .then(data => {
                console.log("Status updated:", data)
                element.style.opacity = '1'
            })
            .catch(error => {
                console.error("Error updating status:", error)
                element.style.opacity = '1'
            })
    }
}