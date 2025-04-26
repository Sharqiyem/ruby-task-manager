import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs'

export default class extends Controller {
    static targets = ["column"]

    connect() {
        this.columnTargets.forEach(column => {
            new Sortable(column, {
                group: 'shared',
                animation: 150,
                ghostClass: 'drag-ghost',
                dragClass: 'drag-item',
                onEnd: this.handleDragEnd.bind(this)
            })
        })
    }

    handleDragEnd(event) {
        const taskId = event.item.dataset.taskId
        const newStatus = event.to.dataset.status

        console.log('Drag ended:', {
            taskId: taskId,
            newStatus: newStatus,
            fromElement: event.from,
            toElement: event.to,
            item: event.item
        })

        if (taskId && newStatus) {
            this.updateTaskStatus(taskId, newStatus)
        } else {

            console.error('Missing taskId or newStatus:', { taskId, newStatus })

        }
    }

    async updateTaskStatus(taskId, newStatus) {
        try {
            // Show loading state
            const taskElement = document.querySelector(`[data-task-id="${taskId}"]`)
            taskElement.style.opacity = '0.5'

            const response = await fetch(`/tasks/${taskId}/update_status`, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector("[name='csrf-token']").content,
                    'Accept': 'application/json'
                },
                body: JSON.stringify({ status: newStatus })
            })

            if (!response.ok) {
                throw new Error('Failed to update task status')
            }

            // Reset opacity and show success feedback
            taskElement.style.opacity = '1'
            this.showToast('Task status updated successfully', 'success')
        } catch (error) {
            console.error('Error updating task status:', error)
            this.showToast('Failed to update task status', 'error')
            window.location.reload()
        }
    }

    showToast(message, type) {
        // Add your preferred toast notification library here
        // For example, using Bootstrap's toast:
        const toastHTML = `
          <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <div class="toast align-items-center text-white bg-${type === 'success' ? 'success' : 'danger'} border-0" role="alert" aria-live="assertive" aria-atomic="true">
              <div class="d-flex">
                <div class="toast-body">
                  ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
              </div>
            </div>
          </div>
        `
        document.body.insertAdjacentHTML('beforeend', toastHTML)
        const toast = document.querySelector('.toast')
        const bsToast = new bootstrap.Toast(toast)
        bsToast.show()
    }
}