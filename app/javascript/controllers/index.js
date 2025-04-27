import { application } from "./application"
import SortableController from "./sortable_controller"
import ConfirmationController from "./confirmation_controller"

application.register("sortable", SortableController)
application.register("confirmation", ConfirmationController)

console.log("Controllers loaded")