import { Middleware } from '../middleware/middleware.js';
import config from '../config/config.js';
import ApiService from '../services/apiService.js';

class ModelBuilder {
  constructor(modelClass) {
    this.modelClass = modelClass
    this.middlewares = new Middleware(); // Create an instance of the Middleware class
    this.data = [];
    this.loading = false;
    this.error = null;
    this.observers = [];
    this.serviceEndpoint = '';
    this.serviceMethod = '';
    this.controllerMiddlewares = [];
  }

  withData(data) {
    this.data = data;
    return this;
  }

  withLoading(loading) {
    this.loading = loading;
    return this;
  }

  withError(error) {
    this.error = error;
    return this;
  }

  withObservers(observers) {
    this.observers = observers;
    return this;
  }

  withServiceEndpoint(endpoint) {
    this.serviceEndpoint = endpoint;
    return this;
  }

  withServiceMethod(method) {
    this.serviceMethod = method;
    return this;
  }

  withControllerMiddlewares(middlewares) {
    this.controllerMiddlewares = middlewares;
    return this;
  }

  build() {
    const model = new this.modelClass();
    model.middlewares = this.middlewares;
    model.data = this.data;
    model.loading = this.loading;
    model.error = this.error;
    model.observers = this.observers;
    model.serviceEndpoint = this.serviceEndpoint;
    model.serviceMethod = this.serviceMethod;
    model.controllerMiddlewares = this.controllerMiddlewares;
    return model;
  }
}



export { ModelBuilder };
