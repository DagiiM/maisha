
import Controller from '../../vitals/controllers/controller.js'; // Update the import path as needed

class EventController extends Controller {
  constructor(model, view, middlewares = [],eventsystem, config = {}) {
    super(model, view, middlewares,eventsystem, config);
  }

}

export default EventController;
