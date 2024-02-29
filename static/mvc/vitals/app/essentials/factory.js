// factory.js

class ModelFactory {
  static create(strategy, ModelClass,config = {}) {
    return strategy(ModelClass,config);
  }
}

class ControllerFactory {
  static create(strategy, ControllerClass, model, view, middlewares,config = {}) {
    return strategy(ControllerClass, model, view, middlewares,config);
  }
}

class ViewFactory {
  static create(strategy, ViewClass, config = {}) {
    return strategy(ViewClass,config);
  }
}

export { ModelFactory, ControllerFactory, ViewFactory };
