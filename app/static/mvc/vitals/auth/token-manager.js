export class TokenManager {
    constructor(itemName) {
      this.itemName = itemName;
      this.itemValue = null;
    }
  
    setItem(value) {
      this.itemValue = value;
      sessionStorage.setItem(this.itemName, value);
    }
  
    getItem() {
      if (this.itemValue === null) {
        const storedValue = sessionStorage.getItem(this.itemName);
        this.itemValue = storedValue;
      }
      return this.itemValue;
    }
  
    clearItem() {
      this.itemValue = null;
      sessionStorage.removeItem(this.itemName);
    }
  }