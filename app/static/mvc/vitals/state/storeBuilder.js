import {Store} from './store.js'

export class StoreBuilder {
    constructor() {
      this.storageStrategy = null;
      this.encryptionStrategy = null;
    }
  
    withStorageStrategy(storageStrategy) {
      this.storageStrategy = storageStrategy;
      return this;
    }
  
    withEncryptionStrategy(encryptionStrategy) {
      this.encryptionStrategy = encryptionStrategy;
      return this;
    }
  
    build() {
      if (!this.storageStrategy) {
        throw new Error("Storage strategy is required.");
      }
  
      const store = new Store(this.storageStrategy);
  
      if (this.encryptionStrategy) {
        store.setEncryptionStrategy(this.encryptionStrategy);
      }
  
      return store;
    }
  }
  
