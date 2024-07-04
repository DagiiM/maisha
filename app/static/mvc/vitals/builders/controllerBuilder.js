class ControllerBuilder {
    constructor(controllerClass) {
      this.model = null;
      this.view = null;
      this.middlewares = [];
      this.controllerClass = controllerClass;
    }
  
    withModel(model) {
      this.model = model;
      return this;
    }
  
    withView(view) {
      this.view = view;
      return this;
    }
  
    withMiddlewares(middlewares) {
      this.middlewares = middlewares;
      return this;
    }
  
    build() {
      const controller = new this.controllerClass();
      controller.model = this.model;
      controller.view = this.view;
      controller.middlewares = this.middlewares;
      this.model.addObserver(this.view); // Register the view as an observer
      return controller;
    }
  }

  
  export { ControllerBuilder };
  