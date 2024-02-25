// Store.js
export class Store {
  constructor(storageStrategy) {
    this.state = {
      data: null,
      user: null,
      eventSystem: null,
    };
    this.listeners = [];
    this.storageStrategy = storageStrategy;
    this.encryptionStrategy = null;
    this.status = {
      idle:true,
      loading:false,
      complete:false
    };

  }

  set_status_idle(){
    this.status.loading=false;
    this.status.complete=false;
    this.status.idle=true;
  }

  set_status_loading(){
    this.status.idle=false;
    this.status.loading=true;
    this.status.complete=false;
  }

  set_status_complete(){
    this.status.idle=true;
    this.status.loading=false;
    this.status.complete=true;
  }

  setEncryptionStrategy(encryptionStrategy) {
    this.encryptionStrategy = encryptionStrategy;
  }
  
    getState() {
      return this.state;
    }
  
    updateState(newState) {
      this.state = { ...this.state, ...newState };
      this.notifyListeners();
    }
  
    subscribe(listener) {
      this.listeners.push(listener);
    }
  
    notifyListeners() {
      for (const listener of this.listeners) {
        listener(this.state);
      }
    }

  // Persist the state using the storage and encryption strategies
  persistState() {
    let dataToStore = JSON.stringify(this.state);

    if (this.encryptionStrategy) {
      dataToStore = this.encryptionStrategy.encrypt(dataToStore);
    }

    this.storageStrategy.setItem("appState", dataToStore);
  }

  // Retrieve the state using the storage and encryption strategies
  retrieveState() {
    const storedData = this.storageStrategy.getItem("appState");

    if (!storedData) {
      return this.state;
    }

    let decryptedData = storedData;

    if (this.encryptionStrategy) {
      decryptedData = this.encryptionStrategy.decrypt(storedData);
    }

    return JSON.parse(decryptedData);
  }
  }
  
  