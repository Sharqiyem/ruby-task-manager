import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// document.addEventListener("turbo:load", function () {
//     var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
//     var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
//         return new bootstrap.Tooltip(tooltipTriggerEl)
//     })
// })

// document.addEventListener('DOMContentLoaded', () => {
//     console.log('Stimulus controllers:', Object.keys(window.Stimulus.application.controllers))
// })

export { application }
