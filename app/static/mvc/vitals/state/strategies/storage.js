// Storage.js
class Storage {
    constructor(strategy) {
      this.strategy = strategy;
    }
  
    getItem(key) {
      return this.strategy.getItem(key);
    }
  
    setItem(key, value) {
      this.strategy.setItem(key, value);
    }
  
    removeItem(key) {
      this.strategy.removeItem(key);
    }

    
  }
  
  export default Storage;
  