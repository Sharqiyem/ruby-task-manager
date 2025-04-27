import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import SortableController from "./controllers/sortable_controller"

// Start Stimulus application
window.Stimulus = Application.start()

// Register controllers
window.Stimulus.register("sortable", SortableController)

console.log("Application initialized")