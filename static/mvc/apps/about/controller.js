
import Controller from '../../vitals/controllers/controller.js'; // Update the import path as needed

class AboutController extends Controller {
  constructor(model, view, middlewares = [],eventsystem, config = {}) {
    super(model, view, middlewares,eventsystem, config);
  }

}

export default AboutController;
