// cacheMiddleware.js
import Middleware from './middleware';

class CacheMiddleware extends Middleware {
  constructor() {
    super(); // Call the constructor of the parent Middleware class
    this.cache = new Map(); // Use a Map to store cached responses
  }

  async execute(request, requestOptions) {
    const cacheKey = this.generateCacheKey(request);

    // Check if the response is cached
    if (this.cache.has(cacheKey)) {
      // Return the cached response
      return this.cache.get(cacheKey);
    }

    // If not cached, continue with the request
    const response = await super.execute(request, requestOptions);

    // Cache the response if it's successful
    if (response !== null) {
      this.cache.set(cacheKey, response);
    }

    return response;
  }

  generateCacheKey(request) {
    // Generate a unique cache key based on the request parameters
    // You can customize this key generation logic based on your API and request structure
    const { endpoint, requestOptions } = request;
    return `${endpoint}:${JSON.stringify(requestOptions)}`;
  }
}

export default CacheMiddleware;
