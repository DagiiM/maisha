import config from '../config/config.js';

class ApiService {
  constructor() {
    this.config = config;
    this.errorHandler = new ErrorHandler();
    this.responseParser = new ResponseParser();
    this.retryConfig = {
      maxRetries: 3,
      retryDelay: 1000, // in milliseconds
    };
    this.lastRequestTime = 0;
    this.requestQueue = [];
    this.isProcessingQueue = false;
  }

  async fetchDataWithRetries(endpoint, method = 'GET', data = null, options = {}) {
    const requestOptions = { ...options, method, data };
    
    try {
      const response = await this.request(endpoint, requestOptions);
      return response;
    } catch (error) {
      return this.retryRequest(endpoint, requestOptions, 1);
    }
  }

  async retryRequest(endpoint, requestOptions, retryCount) {
    if (retryCount <= this.retryConfig.maxRetries) {
      await this.delay(this.retryConfig.retryDelay);
      return this.fetchDataWithRetries(endpoint, requestOptions);
    } else {
      return this.errorHandler.handleError(new Error('Request failed after retries'));
    }
  }
  

  async delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async request(endpoint, requestOptions) {
    const url = this.buildUrl(endpoint);
    const { method = 'GET', data = null, options = {} } = requestOptions;
    const mergedHeaders = { ...this.config.DEFAULT_HEADERS, ...options.headers };
  
    if (requestOptions.authenticated === true) {
      if (!sessionStorage.getItem(this.config.LOGIN_ID)) {
        window.location.href = this.config.LOGIN_URL;
      }
      mergedHeaders['Authorization'] = `${this.config.AUTH_PREFIX} ${sessionStorage.getItem('token')}`;
    }
  
    const response = await fetch(url, {
      method,
      headers: mergedHeaders,
      body: data ? JSON.stringify(data) : null,
    });
  
    if (!response.ok) {
      throw new Error(`Request failed with status ${response.status}`);
    }
  
    return response.json();
  }
  
    buildUrl(endpoint) {
      const formattedEndpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
      return `${this.config.API_BASE_URL}/${formattedEndpoint}`;
    }

  async throttleRequests() {
    const currentTime = new Date().getTime();
    const timeSinceLastRequest = currentTime - this.lastRequestTime;
    if (timeSinceLastRequest < 1000) {
      this.requestQueue.push(this.processQueue.bind(this));
      if (!this.isProcessingQueue) {
        this.processQueue();
      }
    } else {
      this.lastRequestTime = currentTime;
    }
  }

  async processQueue() {
    if (this.requestQueue.length > 0) {
      this.isProcessingQueue = true;
      await this.requestQueue.shift()();
      this.isProcessingQueue = false;
      if (this.requestQueue.length > 0) {
        this.processQueue();
      }
    }
  }

  async fetch(endpoint, data = null, options = {}) {
    return await this.fetchDataWithRetries(endpoint, 'GET', data, options);
  }
  
  async create(endpoint, data, options = {}) {
    return await this.fetchDataWithRetries(endpoint, 'POST', data, options);
  }
  
  async update(endpoint, data, options = {}) {
    return await this.fetchDataWithRetries(endpoint, 'PUT', data, options);
  }
  
  async delete(endpoint, data = null, options = {}) {
    return await this.fetchDataWithRetries(endpoint, 'DELETE', data, options);
  }
  
  async fetchPaginated(endpoint, page = 1, perPage = 10, options = {}) {
    const queryParameters = `page=${page}&per_page=${perPage}`;
    const fullEndpoint = `${endpoint}?${queryParameters}`;
    return await this.fetchDataWithRetries(fullEndpoint, 'GET', null, options);
  }
  
  async fetchWithCache(endpoint, useCache = true, options = {}) {
    if (useCache) {
      // Implement caching logic here
    }
    return await this.fetch(endpoint, options);
  }
  
  async fetchWithOptimization(endpoint, useOptimization = true, options = {}) {
    if (useOptimization) {
      // Implement optimization logic here
    }
    return await this.fetch(endpoint, options);
  }
  
  async fetchAndSubscribe(endpoint, subscriber, options = {}) {
    // Implement subscription logic here
    const data = await this.fetch(endpoint, options);
    subscriber(data);
  }
  

  // ... other advanced API-related methods
}

export class ErrorHandler {
  handleError(error) {
    // Handle different types of errors and provide user-friendly feedback
    console.error('An error occurred:', error);
    return null;
  }
}

export class ResponseParser {
  parse(response) {
    // Implement response parsing logic here
    if (!response.ok) {
      throw new Error(`Request failed with status ${response.status}`);
    }
    return response.json();
  }
}



export default ApiService;
