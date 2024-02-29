import AppServiceProvider from '../providers/appServiceProvider.js';

class AppManager {
  constructor() {
    this.appServiceProvider = new AppServiceProvider();
  }

  async createApp(appName, middleware = [], classNames = {}) {
    try {
      // Extract custom class names or use defaults
      const { model = 'model', view = 'view', controller = 'controller' } = classNames;

      // Dynamically import the required modules based on the app name
      const { default: ModelClass } = await import(`../../apps/${appName}/${model}.js`);
      const { default: ViewClass } = await import(`../../apps/${appName}/${view}.js`);
      const { default: ControllerClass } = await import(`../../apps/${appName}/${controller}.js`);

      // Check if modules were loaded successfully
      if (!ModelClass || !ViewClass || !ControllerClass) {
        throw new Error(`Failed to load one or more modules for ${appName}`);
      }
    
      // Create the app using the AppServiceProvider with the instantiated classes
      return this.appServiceProvider.createApp(ModelClass, ViewClass, ControllerClass, middleware);
    } catch (error) {
      console.error(`Error creating app: ${error}`);
      return null;
    }
  }
}

export default AppManager;
