const config = {
    API_BASE_URL: 'http://172.105.77.24',//'https://a7bc-102-219-209-182.ngrok-free.app', // Your API base URL
    DEFAULT_HEADERS: {
      'Content-Type': 'application/json', // Default content type
      // You can add more default headers here
    },
    LOGIN_ID : 'userID',
    ALTENATE_LOGIN_ID : 'staffID' ,
    LOGIN_URL : '/login',
    AUTH_PREFIX : 'Token',
    DEFAULT_AUTHENTICATED : {authenticated:false},
    HOME:'/dashboard'
  };
  
export function loadCSS(cssFileName) {
    const link = document.createElement('link');
    link.rel = 'stylesheet';
    link.type = 'text/css';
    link.href = cssFileName;
    document.head.appendChild(link);
  }

  export default config;

