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
  
    services.forEach((service,index) => {
      // Create HTML element for the program section
      const serviceSection = document.createElement('article');
      serviceSection.classList.add('eleso-them', 'eleso-border-round','eleso-mb-2',);
 
      let serviceWarpper = document.createElement('div');
      serviceWarpper.classList.add('eleso-grid-container-col-1','eleso-p-4','eleso-wrapper--large', 'eleso-theme-secondary-lighter');
  //serviceWarpper.style="background-color:hsl(22.14deg 36.52% 45.1%)";
      let image = `<img class="eleso-aligned-image-block__image" src="${service.image.versions.thumbnail}" alt="${service.image.caption}" loading="lazy"/>`
      let content = `
          <div class="eleso-aligned-image-block__content">
             <h2 class="eleso-font-executive">${service.title}</h2>
             <p class="eleso-font-subtle eleso-ptb-1">${service.description}</p>
          </div>
      `;
      this.contentAlign(serviceWarpper,index,image,content);
      serviceSection.appendChild(serviceWarpper)
      
      // Append program section to the main container
      const programContainer = document.getElementById('service-container');
      programContainer.appendChild(serviceSection);
    });
  }

  contentAlign(wrapper, index, image, content){
    const viewportWidth = document.documentElement.clientWidth;
    if(viewportWidth >= 920){
      if (index % 2 === 0) {
        wrapper.innerHTML = image + content; // Image on the left
    } else {
        wrapper.innerHTML = content + image; // Image on the right
    }
    return wrapper
    }else{
      wrapper.innerHTML = image + content; // Image on the left
      return wrapper
    }
    
  }


  
  AboutServiceContainer(data) {
      if(data[0]){
        let introx = document.querySelector('main #service-intro');
        let p = document.querySelector('main .eleso-hero-section__description');
        let image = document.querySelector('main .eleso-hero-section img');
     
        p.innerHTML=`${data[0].content || 'No About Program Content Yet'}`
  
        if (data[0].image){
          //introx.style=`background-image:url(${getImageUrl(data[0].image.versions)})`;
 
          image.src = `${getImageUrl(data[0].image.versions)}`;
          image.alt = `${data[0].image.caption}`;
        }
      }

    }

    
}

export default ServiceView;