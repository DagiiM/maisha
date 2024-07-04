// serviceWorkerMiddleware.js
import Middleware from './middleware';

class ServiceWorkerMiddleware extends Middleware {
  constructor() {
    super(); // Call the constructor of the parent Middleware class
  }

  async execute(request, requestOptions) {
    // Check if Service Workers are supported by the browser
    if ('serviceWorker' in navigator) {
      // Register a Service Worker if not already registered
      if (!navigator.serviceWorker.controller) {
        try {
          const registration = await navigator.serviceWorker.register('/sw.js');
          console.log('Service Worker registered:', registration);
        } catch (error) {
          console.error('Service Worker registration failed:', error);
        }
      }
    } else {
      console.warn('Service Workers are not supported in this browser.');
    }

    // Continue with the request
    return super.execute(request, requestOptions);
  }
}

export default ServiceWorkerMiddleware;
