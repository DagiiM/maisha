  import config from "../config/config.js";
  import { AuthService } from "../services/auth-service.js";
  
  export class Authenticator {
    static __instance = null;
  
    static getInstance() {
      if (Authenticator.__instance === null) {
        Authenticator.__instance = new Authenticator();
      }
      return Authenticator.__instance;
    }
  
    constructor() {
      if (Authenticator.__instance !== null) {
        throw new Error('Cannot instantiate more than one Authenticator instance');
      }
      this.authService = new AuthService();
      Authenticator.__instance = this;
    }
  
    async login(credentials) {
      try {
        await this.authService.login(credentials);
      } catch (error) {
        throw error;
      }
    }
  
    async logout() {
      try {
        await this.authService.logout();
      } catch (error) {
        throw error;
      }
    }
    
  }