import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
    static targets = ["column"]

    connect() {
        console.log("Sortable controller connected")
        this.initializeSortable()
    }

    initializeSortable() {
        console.log("Initializing Sortable...")
        this.columnTargets.forEach(column => {
            new Sortable(column, {
                group: 'tasks',
                animation: 150,
                dragClass: 'drag-item',
                ghostClass: 'drag-ghost',
                onStart: (evt) => {
                    console.log('Drag started:', evt)
                },
                onEnd: this.updateStatus.bind(this)
            })
        })
    }

    updateStatus(event) {
        console.log('Drag ended:', event)
        const taskId = event.item.dataset.taskId
        const newStatus = event.to.dataset.status
        console.log('Updating task:', { taskId, newStatus })

        fetch(`/tasks/${taskId}/update_status`, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
            },
            body: JSON.stringify({ status: newStatus })
        })
            .then(response => response.json())
            .then(data => console.log('Update successful:', data))
            .catch(error => console.error('Error updating task:', error))
    }
}