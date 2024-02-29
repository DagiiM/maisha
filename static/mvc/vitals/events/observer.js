
 export class Observer {
    constructor() {
      this.observers = [];
    }

    subscribe(observer, priority = 0) {
      if (typeof observer.update === 'function') {
        this.observers.push({ observer, priority });
        this.observers.sort((a, b) => b.priority - a.priority); // Higher priority first
      }
    }
  
    unsubscribe(fn) {
      this.observers = this.observers.filter((subscriber) => subscriber !== fn);
    }

    notify(data,container) {
      this.observers.forEach((subscriber) => {
          subscriber.observer.update(data,container);
      });
    }
    
  }