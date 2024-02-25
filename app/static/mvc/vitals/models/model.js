
import {Middleware} from '../middleware/middleware.js';
import config from "../config/config.js";

class Model{
  constructor(eventSystem,config={}) {
    this.config=config;
    this.middlewares = new Middleware();
    this.data = [];
    this.error = null;
    this.eventSystem = eventSystem;
    this.observer = eventSystem.observer
  }

  async service_request(serviceEndpoint,serviceMethod,containerMethod,controllerMiddlewares = []) {
    try {
     this.eventSystem.store.set_status_loading();
     this.observer.notify(this.eventSystem.store,containerMethod);

      const request = {
        service_endpoint: serviceEndpoint,
        options: {
          authenticated: { ...config.DEFAULT_AUTHENTICATED },
          service_method: serviceMethod,
        },
      };

      // Use the Middleware class to execute the request
      const data = await this.middlewares.execute(request, controllerMiddlewares);
      this.data = data;
      
      this.setData(this.data)
      // Handle the response data as needed
      this.eventSystem.store.set_status_idle();
      this.observer.notify(this.data,containerMethod);
      //return this.data;
    } catch (error) {
      this.eventSystem.store.set_status_idle();
      this.observer.notify(this.data,containerMethod);
      this.error = error;
      throw error;
    }
  }


  setData(data) {
    this.eventSystem.store.state.data = data;
    this.eventSystem.store.persistState();
  }

  setUserData(user) {
    this.eventSystem.store.state.user = user;
    this.eventSystem.store.persistState();
  }
  
}

export default Model;