
class Controller {
  constructor(model, view, middlewares = [],eventsystem, config={}) {
    this.eventSystem = eventsystem;
    this.config=config;
    this.model = model;
    this.view = view;
    this.middlewares = middlewares;
    this.observer = this.eventSystem.observer
    this.observer.subscribe(this.view);
  }

  async updateView(endpoint, method='fetch',containerMethod,middlewares=this.middlewares) {
    try {
      const data = await this.model.service_request(endpoint, method,containerMethod, middlewares);
      //this.view.render(data);
    } catch (error) {
      // Handle errors if needed
      console.error('Error updating view:', error);
    }
  }

  init() {
    let endpoints =  this.view.endpoints;
    
    if(endpoints){
      let endpointOrder = Object.keys(endpoints);

      for (const key of endpointOrder) {
          const endpointData = endpoints[key];
          const { url, method, containerMethod } = endpointData;
          this.updateView(url, method, containerMethod);
        }
    }
  }

/*
  init() {
    let endpoints = this.view.endpoints
    if(endpoints) {
      for (const key in endpoints) {
        if (endpoints.hasOwnProperty(key)) {
          const endpointData = endpoints[key];
          const {url, method, containerMethod} = endpointData
          this.updateView(url,method,containerMethod);
        }
      }
    }
  }
  */

}

export default Controller;