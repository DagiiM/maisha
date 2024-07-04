// Event Prioritization
export class EventPrioritization {
    constructor() {
      this.eventQueue = [];
    }
  
    addEvent(event, priority = 0) {
      this.eventQueue.push({ event, priority });
      this.eventQueue.sort((a, b) => b.priority - a.priority); // Higher priority first
    }
  
    processEvents() {
      while (this.eventQueue.length > 0) {
        const { event } = this.eventQueue.shift();
        console.log(`Processing event with priority ${event.priority}: ${event.data}`);
      }
    }
  }
  
  // Global Event Bus
  export class GlobalEventBus {
    constructor() {
      this.listeners = {};
    }
  
    subscribe(event, callback) {
      if (!this.listeners[event]) {
        this.listeners[event] = [];
      }
      this.listeners[event].push(callback);
    }
  
    emit(event, data) {
      if (this.listeners[event]) {
        this.listeners[event].forEach(callback => {
          callback(data);
        });
      }
    }
  }