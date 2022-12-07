import { Application } from "@hotwired/stimulus"
import { get, post, put, patch, destroy } from "@rails/request.js";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
