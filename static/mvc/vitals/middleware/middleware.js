
import ApiService from '../services/apiService.js';

export class Middleware {
  constructor() {
    this.middlewares = [];
    this.apiService = new ApiService();
  }

  use(middlewareFunction, options = {}) {
    this.middlewares.push({ middlewareFunction, options });
  }

  async execute(request, requestOptions) {
    let response = request;

    try {
      for (const middleware of this.middlewares) {
        const { middlewareFunction, options } = middleware;

        // Check if the request should be canceled
        if (options.cancelToken && options.cancelToken.reason) {
          throw new Error('Request canceled');
        }

        response = await middlewareFunction(response, requestOptions, response, options);

        if (response === null) {
          // Middleware blocked the request, stop processing
          return null;
        }
      }

      // Call executeApiFunction after all middlewares have been executed
      if (request.options.service_method) {
        return this.executeApiFunction(request.options.service_method, response.service_endpoint, response.data, request.options.authenticated);
      }

      return response;
    } catch (error) {
      // Handle errors, including cancellation
      if (error.message === 'Request canceled') {
        // Handle cancellation
        console.log('Request was canceled');
        return null;
      } else {
        // Handle other errors
        console.error('Middleware error:', error);
        throw error;
      }
    }
  }

  // Combine middlewares for controller and model
  combineMiddlewares(controllerMiddlewares, modelMiddlewares) {
    return [...controllerMiddlewares, ...modelMiddlewares];
  }

  // Dynamically construct the API request based on function name
  async executeApiFunction(functionName, endpoint, data, options) {
    if (!this.apiService[functionName]) {
      throw new Error(`Invalid function name: ${functionName}`);
    }

    return this.apiService[functionName](endpoint, data, options);
  }
}
