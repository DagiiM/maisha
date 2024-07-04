
import {EventPrioritization,GlobalEventBus} from './event.js';
import {Observer}  from './observer.js';

export class EventSystemBuilder {
  constructor(store) {
    this.observerPatternEnabled = false;
    this.eventPrioritizationEnabled = false;
    this.globalEventBusEnabled = false;
    this.eventConfig = {};
    this.eventSystem = {};
    this.eventSystem.store = store; // Pass the central store
    /*
    this.observer = null;
    this.eventPrioritization = null;
    this.globalEventBus = null;
    this.eventConfig = null;
    */
  }

  enableObserverPattern() {
    this.observerPatternEnabled = true;
    return this;
  }

  enableEventPrioritization() {
    this.eventPrioritizationEnabled = true;
    return this;
  }

  enableGlobalEventBus() {
    this.globalEventBusEnabled = true;
    return this;
  }

  configureEvents(config) {
    this.eventConfig = config;
    return this;
  }

  build() {
    if (this.observerPatternEnabled) {
      this.eventSystem.observer = new Observer();
    }

    if (this.eventPrioritizationEnabled) {
      this.eventSystem.eventPrioritization = new EventPrioritization();
    }

    if (this.globalEventBusEnabled) {
      this.eventSystem.globalEventBus = new GlobalEventBus();
    }

    this.eventSystem.eventConfig = this.eventConfig;
/*
    // Initialize the state using the central store
    this.store.updateState({
      eventSystem: this.eventSystem, // Pass the event system to the state
    });
*/

    return this.eventSystem.eventSystem;
  }
}

