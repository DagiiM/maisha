import getImageUrl from '../utils/image_version.js'

class View {
    constructor(eventsystem,config={}) {
      this.eventSystem = eventsystem;
      this.config=config;
      this.container = document.querySelector("main");
      this.eventHandlers = {}; // Initialize eventHandlers
      this.loaderElement =  this.createLoaderElement(); // Create the loader element
      this.updateLoaderVisibility(false); // Initially hide the loader

    }

      endpoints = {
          organization : {
            url : 'api/organizations/',
            method : 'fetch',
            containerMethod : this.organizationInfo.bind(this),
        },
    
      };


        
      update(data,container) {
        if (this.eventSystem.store.status.loading) {
          // Show loading spinner or message
          this.updateLoaderVisibility(true);
        }else {
          // Data is ready, render the view
          this.updateLoaderVisibility(false);
          this.render(data,container);
        }
      }

      render(data,container){
        container(data)
      }

      // Create the loader element and add it to the body
      createLoaderElement() {
        const loader = document.createElement('section');
        loader.classList.add('loader');
        loader.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="111px" height="111px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
        <circle cx="30" cy="50" fill="#e90c2c" r="20">
          <animate attributeName="cx" repeatCount="indefinite" dur="1s" keyTimes="0;0.5;1" values="30;70;30" begin="-0.5s"/>
        </circle>
        <circle cx="70" cy="50" fill="#394719" r="20">
          <animate attributeName="cx" repeatCount="indefinite" dur="1s" keyTimes="0;0.5;1" values="30;70;30" begin="0s"/>
        </circle>
        <circle cx="30" cy="50" fill="#e90c2c" r="20">
          <animate attributeName="cx" repeatCount="indefinite" dur="1s" keyTimes="0;0.5;1" values="30;70;30" begin="-0.5s"/>
          <animate attributeName="fill-opacity" values="0;0;1;1" calcMode="discrete" keyTimes="0;0.499;0.5;1" dur="1s" repeatCount="indefinite"/>
        </circle>
        </svg>`;
        document.body.appendChild(loader);
        return loader;
      }

      // Update the loader's visibility based on the provided flag
      updateLoaderVisibility(visible) {
        this.loaderElement.style.display = visible ? 'flex' : 'none';
      }
    

      bind(eventName, handler) {
        if (!this.eventHandlers[eventName]) {
          this.eventHandlers[eventName] = [];
        }
        this.eventHandlers[eventName].push(handler);
        this[eventName] = (event) => {
          this.eventHandlers[eventName].forEach(h => h(event));
        };
      }

    organizationInfo(data) {
      if (data && data.results && data.results.length > 0) {
          let organization  = data.results[0];
          let video = organization.video;

          let posterContainer = document.querySelector('.eleso-video-container img');
          let videoContainer = document.querySelector('.eleso-video-container video source');
          
          if(video){
            let poster = getImageUrl(video.poster.versions);
            if(videoContainer){
              posterContainer.setAttribute('src',poster)
              posterContainer.setAttribute('alt',video.poster.caption)
              videoContainer.setAttribute('src',video.file)
            }
          }


          let contact_info = organization.contact_info;

          let mobile_number = document.querySelector('.contact-hotline .mobile_number');
          let email = document.querySelector('.contact-hotline .email');

          let mobile_mobile_number = document.querySelector('mobile .contact-hotline .mobile-mobile_phone');
          let mobile_email = document.querySelector('mobile .contact-hotline .mobile-email');

          if(mobile_number){
            mobile_number.innerText=`${contact_info.phone}`
          }
          if(email){
            email.innerText=`${contact_info.email}`
          }

          if(mobile_mobile_number){
            mobile_mobile_number.innerText=`${contact_info.phone}`
          }

          if(mobile_email){
          mobile_email.innerText=`${contact_info.email}`
          }
          
          let maisha_mission_section_p = document.querySelector('.maisha-mission-section p');
          if(maisha_mission_section_p){
            maisha_mission_section_p.innerText = organization.mission
          }

          let footer_contact_card = document.querySelector('.footer-contact-card')

          if(footer_contact_card){
            let mail = document.querySelector('.footer-contact-card .email');
            let phone = document.querySelector('.footer-contact-card .phone');
            let address = document.querySelector('.footer-contact-card .address');

            mail.innerHTML = `<i class="icon-email"></i> : <a href="mailto:${contact_info.email}"  class="eleso-link" aria-label="Contact us">${contact_info.email}</a>`;
            address.innerHTML = `<i class="icon-map"></i> : <p>${organization.address.postal_code}, State: ${organization.address.state}, City: ${organization.address.city} </p>`;
            phone.innerHTML = `<i class="icon-phone_enabled"></i> : <a href="tel:${contact_info.phone}" class="eleso-link" aria-label="Call Us">${contact_info.phone}</a>`;
        
          }
      }
      else{
        console.error('Invalid data or no results found');
      }
     //this.organizationContactInfo(organization);

  }

  }
  
export default View;