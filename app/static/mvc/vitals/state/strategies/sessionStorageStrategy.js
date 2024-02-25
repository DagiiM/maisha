// SessionStorageStrategy.js
import StorageStrategy from "./storageStrategy.js";
import EncryptionStrategy from "../../encryption/strategies/encryptionStrategy.js"

class SessionStorageStrategy extends StorageStrategy {
  constructor() {
    super();
    this.encryptionStrategy = new EncryptionStrategy();
  }
  getItem(key) {
    const encryptedData = localStorage.getItem(key);
    const decryptedData = this.encryptionStrategy.decrypt(encryptedData);
    return decryptedData;
  }

  setItem(key, value) {
    const encryptedValue = this.encryptionStrategy.encrypt(value);
    localStorage.setItem(key, encryptedValue);
  }

  removeItem(key) {
    sessionStorage.removeItem(key);
  }
}

export default SessionStorageStrategy;
