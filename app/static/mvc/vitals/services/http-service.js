import config from "../config/config.js";

export class HttpService {
    constructor() {
      this.base_url = config.API_BASE_URL;
    }

    async requestWithRetries(endpoint, method, data = null, headers = {}, maxRetries = 3, retryDelay = 1000) {
        let retries = 0;
        while (retries < maxRetries) {
        try {
            return await this.request(endpoint, method, data, headers);
        } catch (error) {
            console.error(`HTTP request failed (retry ${retries + 1}): ${error.message}`);
            retries++;
            await new Promise((resolve) => setTimeout(resolve, retryDelay));
        }
        }
        throw new Error('Max retries exceeded');
    }
    
    async request(endpoint, method, data = null, headers = {}) {
        try {
        const url = `${this.base_url}/${endpoint}`;
        const options = {
            method: method,
            headers: headers,
        };
    
        if (data) {
            options.body = JSON.stringify(data);
        }
    
        const response = await fetch(url, options);
    
        if (!response.ok) {
            const errorResponse = await response.json();
            const errorMessage = errorResponse.message || 'HTTP request failed';
            throw new Error(errorMessage);
        }
    
        return await response.json();
        } catch (error) {
        console.error('HTTP request error:', error.message);
        throw error;
        }
    }
    
    async get(endpoint, headers = {}, maxRetries, retryDelay) {
        return this.requestWithRetries(endpoint, 'GET', null, headers, maxRetries, retryDelay);
    }
    
    async post(endpoint, data = null, headers = {}, maxRetries, retryDelay) {
        return this.requestWithRetries(endpoint, 'POST', data, headers, maxRetries, retryDelay);
    }
    
    async put(endpoint, data = null, headers = {}, maxRetries, retryDelay) {
        return this.requestWithRetries(endpoint, 'PUT', data, headers, maxRetries, retryDelay);
    }
    
    async delete(endpoint, headers = {}, maxRetries, retryDelay) {
        return this.requestWithRetries(endpoint, 'DELETE', null, headers, maxRetries, retryDelay);
    }
    
    }
    