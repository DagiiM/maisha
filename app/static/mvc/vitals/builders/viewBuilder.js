class ViewBuilder {
    constructor(viewClass) {
      this.viewClass = viewClass;
      this.container = document.querySelector("main");
      this.eventHandlers = {};
      this.loaderElement = this.createLoaderElement();
      this.endpoint = '';
    }
  
    withContainer(container) {
      this.container = container;
      return this;
    }
  
    withEventHandlers(eventHandlers) {
      this.eventHandlers = eventHandlers;
      return this;
    }
  
    withLoaderElement(loaderElement) {
      this.loaderElement = loaderElement;
      return this;
    }
  
    withEndpoint(endpoint) {
      this.endpoint = endpoint;
      return this;
    }
  
    build() {
      const view = new this.viewClass();
      view.container = this.container;
      view.eventHandlers = this.eventHandlers;
      view.loaderElement = this.loaderElement;
      view.endpoint = this.endpoint;
      return view;
    }
  }
  
  export { ViewBuilder };
  