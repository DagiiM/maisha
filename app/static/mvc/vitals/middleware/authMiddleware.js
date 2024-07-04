import { Middleware } from './middleware.js';
import { Authenticator } from '../auth/authenticator.js';

class AuthMiddleware extends Middleware {
  constructor() {
    super(); // Call the constructor of the parent class (Middleware)
    this.authenticator  = new Authenticator();
  }

  async execute(request, middlewares) {
    const config = this.config;
    
    if (this.authenticator.AuthService.isAuthenticated()) {
      // If authenticated, continue with the request
      return super.execute(request, middlewares);
    } else {
        window.location.href = config.LOGIN_URL;
    }
  }

}

export { AuthMiddleware };
