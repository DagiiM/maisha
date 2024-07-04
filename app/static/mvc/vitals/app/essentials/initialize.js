import  {ModelStrategies,ControllerStrategies,ViewStrategies} from './strategies.js';
import {ModelFactory,ControllerFactory,ViewFactory} from './factory.js';

class Initialize{
    constructor(ModelClass,ControllerClass,ViewClass){
        this.ModelClass = ModelClass;
        this.ControllerClass = ControllerClass;
        this.ViewClass = ViewClass;
    }



    init(options = {}){
        // Create a Model using a specific strategy and class name
        const model = ModelFactory.create(ModelStrategies.createSpecialized, this.ModelClass);
        // Create a View using a specific strategy and class name
        const view = ViewFactory.create(ViewStrategies.createSpecialized, this.ViewClass);
        
        // Create a Controller using a specific strategy and class name
        const controller = ControllerFactory.create(
            ControllerStrategies.createDefault, 
            this.ControllerClass, 
            model, 
            view,
            options.middlewares
            );
        return {model,controller,view};
    }
}

export default Initialize;