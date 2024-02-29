import config from '../config/config.js';
import { HttpService } from './http-service.js';
import { TokenManager } from '../auth/token-manager.js';

export class AuthService {
  constructor() {
    this.httpService = new HttpService();
    this.tokenManager = new TokenManager('token'); 
    this.tokenUserID = new TokenManager(config.LOGIN_ID); 
    this.tokenStaffID = new TokenManager(config.ALTENATE_LOGIN_ID);
    this.tokenPrefix = config.AUTH_PREFIX;
    this.token = null;
    this.authenticated = false;
  }

  async login(credentials) {
    try {
      const response = await this.httpService.post('auth/',
       credentials,
       {'Content-Type': 'application/json'}
       );
       
      this.token = response['token'];
      
      this.tokenManager.setItem(this.token);

      await this.fetchUserAndStaffIds(this.token); // Wait for user and staff IDs to be fetched
      this.authenticated=true;
      window.location.href=config.HOME;
    } catch (error) {
      throw error;
    }
  }

  async logout() {
    try {
        const response = await this.httpService.post('auth/logout/',null,
                {
                 'Content-Type': 'application/json',
                 'Authorization': `${this.tokenPrefix} ${this.token}` 
                },
        );
        this.tokenManager.clearItem();
        this.tokenUserID.clearItem();
        this.tokenStaffID.clearItem();
        this.authenticated = false;
        window.location.href=config.LOGIN_URL;
    } catch (error) {
      throw error;
    }
  }

  async fetchUserAndStaffIds(token) {
    try {
      if (!token) {
        throw new Error('Authentication token is missing.');
      }

      const headers = {
        'Content-Type': 'application/json',
        'Authorization': `${this.tokenPrefix} ${token}`,
      };

      const userResponse = await this.httpService.get('/get-user-id/', headers);
      const staffResponse = await this.httpService.get('/get-staff-id/', headers);

      const userId = userResponse['user_id'];
      const staffId = staffResponse['staff_id'];

      this.tokenUserID.setItem(userId);

      if(staffId){
        this.tokenStaffID.setItem(staffId);
      }

    } catch (error) {
      throw error;
    }
  }

  isAuthenticated() {
    // Check if the authentication token exists and if the user is authenticated
    return !!this.tokenManager.getItem() && this.authenticated;
  }
}
