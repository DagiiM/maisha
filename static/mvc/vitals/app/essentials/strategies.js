import {LocalStorageStrategy} from '../../state/strategies/localStorageStrategy.js';
import {EncryptionStrategy} from '../../encryption/strategies/encryptionStrategy.js';
import {StoreBuilder} from '../../state/storeBuilder.js';
import {EventSystemBuilder} from '../../events/eventSystemBuilder.js';
import EventConfig from '../../events/eventConfig.js';

  // Configure your storage strategy and encryption strategy
  const storageStrategy = new LocalStorageStrategy(); // Use LocalStorageStrategy
  const encryptionStrategy = new EncryptionStrategy();

  // Use the StoreBuilder to create the store with strategies
  const store = new StoreBuilder()
    .withStorageStrategy(storageStrategy)
    .withEncryptionStrategy(encryptionStrategy)
    .build();

  // Initialize the Event System
  let eventSystem = new EventSystemBuilder(store);
  eventSystem.enableObserverPattern()
    .enableEventPrioritization()
    .enableGlobalEventBus()
    .configureEvents(EventConfig)
    .build();

  eventSystem = eventSystem.eventSystem


// Strategies for Model creation
const ModelStrategies = {
  createDefault: (ModelClass, config) => new ModelClass(eventSystem,config),
  createSpecialized: (ModelClass, config) => new ModelClass(eventSystem,config),
  // Add more strategies for different types of Model
};

// Strategies for Controller creation
const ControllerStrategies = {
  createDefault: (ControllerClass, model, view, middlewares,config) => new ControllerClass(model, view, middlewares,eventSystem, config),
  createSpecialized: (ControllerClass, model, view, middlewares, config) => new ControllerClass(model, view, middlewares,eventSystem, config),
  // Add more strategies for different types of Controller
};

// Strategies for View creation
const ViewStrategies = {
  createDefault: (ViewClass, config) => new ViewClass(eventSystem,config),
  createSpecialized: (ViewClass, config) => new ViewClass(eventSystem,config),
  // Add more strategies for different types of View
};


export {ModelStrategies , ControllerStrategies, ViewStrategies};