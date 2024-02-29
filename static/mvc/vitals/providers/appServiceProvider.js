
import config, { loadCSS } from '../config/config.js';
import { AuthMiddleware } from '../middleware/authMiddleware.js';
import Initialize from '../app/essentials/initialize.js';


class AppServiceProvider {
  constructor() {
    this.auth_middleware = [];
  }

  createApp(Model, View, Controller, middlewareClasses = []) {
    if(config.DEFAULT_AUTHENTICATED.authenticated){
      this.auth_middleware = AuthMiddleware;
      console.log(config.DEFAULT_AUTHENTICATED)
    }
    const globalMiddlewareOptions = { ...this.auth_middleware };
    const middlewares = [...middlewareClasses, globalMiddlewareOptions]; // Combine middlewares
    
    const initialize = new Initialize(Model, Controller, View);

    const options = {
      middlewares:middlewares
    };

    const {model,controller,view} = initialize.init(options);

    //loadCSS('../static/mvc/vitals/styles/mvc.css');
    
    controller.init()
  }

  
  create(controller) {
    // Set up event listener and initialize the application
    document.addEventListener('DOMContentLoaded', () => {
      controller.init();
    });
  }
  // You can create methods for other app types here
}

export default AppServiceProvider;
