import { Application } from "@hotwired/stimulus"

const application = Application.start()
application.debug = true
window.Stimulus = application

console.log("Stimulus application started")

export { application }