import View from '../../vitals/views/view.js';
import getImageUrl from '../../vitals/utils/image_version.js';

class ServiceView extends View{
    constructor(eventsystem){
        super(eventsystem);
        //this.container = document.querySelector('#officeContainer');

        this.endpoints = {
            ...this.endpoints,
            program : {
                  url : 'api/services/',
                  method : 'fetch',
                  containerMethod : this.ServiceContainer.bind(this),
              },

              about_program : {
                url : 'api/recent-verified-about-services/',
                method : 'fetch',
                containerMethod : this.AboutServiceContainer.bind(this),
            }
              
            };
    }



   ServiceContainer(data) {
    const services = data.results;
  
    services.forEach(service => {
      // Create HTML element for the program section
      const serviceSection = document.createElement('article');
      serviceSection.classList.add('eleso-theme-secondary-lighter', 'eleso-grid-item', 'eleso-box-shadow', 'eleso-border-round', 'eleso-border-2', 'eleso-mb-2', 'eleso-bg-white', 'eleso-hover-link-icon');
 
  
      // Add program content
      serviceSection.innerHTML = `
        <div class="eleso-p-2">
          <div class=""><img src="${service.image.versions.thumbnail}" alt="${service.image.caption}"/></div>
          <h2 class="eleso-font-executive">${service.title}</h2>
          <p class="eleso-font-subtle eleso-pt-1">${service.description}</p>
        </div>
      `;
      
      // Append program section to the main container
      const programContainer = document.getElementById('service-container');
      programContainer.appendChild(serviceSection);
    });
  }


  
  AboutServiceContainer(data) {
      if(data[0]){
        let p = document.querySelector('main #service-intro .about-service');
        let image = document.querySelector('main #service-intro .about-service-image');

        p.innerHTML=`${data[0].content || 'No About Us Content Yet'}`;
        if (data[0].image){
          image.src = `${getImageUrl(data[0].image.versions)}`;
          image.alt = `${data[0].image.caption}`;
        }
      }
    }
}

export default ServiceView;