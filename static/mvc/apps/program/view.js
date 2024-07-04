import View from '../../vitals/views/view.js';
import getImageUrl from '../../vitals/utils/image_version.js';
import { ContentSlider } from '../../vitals/components/content-slider.js';
import { Lightbox } from '../../vitals/components/light-box.js';


import { ActivitySlider } from './components/activity_slider.js';

class ProgramView extends View{
    constructor(eventsystem){
        super(eventsystem);
        //this.container = document.querySelector('#officeContainer');

        this.endpoints = {
            ...this.endpoints,
            program : {
                  url : 'api/programs/',
                  method : 'fetch',
                  containerMethod : this.ProgramContainer.bind(this),
              },

              about_program : {
                url : 'api/recent-verified-about-programs/',
                method : 'fetch',
                containerMethod : this.AboutProgramContainer.bind(this),
            }
              
            };
    }



ProgramContainer(data) {
    const programs = data.results;
  
    programs.forEach(program => {
      // Create HTML element for the program section
      const programSection = document.createElement('div');
      programSection.classList.add('eleso-theme-secondary-light', 'eleso-mb-2', 'eleso-hover-link-icon');
      programSection.id = `program-${program.id}`;
    
      // Add program content
      programSection.innerHTML = `
        <article class="eleso-content-card eleso-theme-secondary-light">
          <h3 class="eleso-content-card__header eleso-font-fancy eleso-font-gradient-shine">${program.title}</h3>
          
          <p class="eleso-content-card__body eleso-content-card__body--truncated">${program.description}</p>
          
          <!-- Add a container for the activity slider -->
          <div class="activity-slider-container"></div>
    
          <div class="eleso-content-card__actions">
            <button class="eleso-content-card__show-more">Show More</button>
            <button class="eleso-content-card__show-less" style="display: none;">Show Less</button>
            <!--
            <a href="#activities" class="eleso-content-card__read-more">
              <span>Read More</span>
              <i class="icon-arrow_right_alt eleso-ml-1 eleso-font-size-4 eleso-text-brand"></i>
            </a>
            -->
          </div>
          <hr class="eleso-warm-line" style="width:20%;margin:25px auto;">
        </article>
      `;
    
      const programContainer = document.getElementById('program-container');
      programContainer.append(programSection);
    
    // Check if the program has activities and activities is defined
    if (program.activities && Array.isArray(program.activities) && program.activities.length > 0) {
      // Initialize the ActivitySlider within the program card
      // const activitySliderContainer = programSection.querySelector('.activity-slider-container');
      let activities_conteiner = this.generateActivityHtmlContent(program.activities)
      programSection.appendChild(activities_conteiner); // Append the activitySliderContainer to the DOM

      //new ActivitySlider(activitySliderContainer, program.activities, this.createItemContent);
    }
    });

  }

  generateActivityHtmlContent(data) {
    const container = document.createElement('section');
    container.className = 'eleso-theme-secondary-light';
    //container.style.padding = '20px';

    data.forEach((item, index) => {
        const wrapper = document.createElement('div');
        wrapper.className = 'eleso-wrapper eleso-wrapper--large eleso-wrapper--section eleso-wrapper--layout eleso-grid eleso-aligned-image-block__wrapper';
        let activity_image = `${getImageUrl(item.image.versions)}`;
        if(activity_image){
          const content = `
          <div class="eleso-aligned-image-block__content">
              <h3 class="eleso-aligned-image-block__title eleso-font-executive">${item.title}</h3>
              <div class="eleso-aligned-image-block__text eleso-list eleso-list--blue">
                  <p class="eleso-content-card__body eleso-content-card__body--truncated">${item.description}</p>
                  <button class="eleso-see-more-btn">See More</button>
              </div>
          </div>
      `;
      

      const image = `
          <img alt="${item.title}" class="eleso-min-image eleso-lazy-animate--loaded" decoding="async" height="360" loading="lazy" src="${activity_image}" width="500">
      `;
      /*
      if (index % 2 === 0) {
          wrapper.innerHTML = image + content; // Image on the left
      } else {
          wrapper.innerHTML = content + image; // Image on the right
      }
      */
     this.contentAlign(wrapper,index,image,content);
    
    }


        container.appendChild(wrapper);
    });

    return container;
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

  createItemContent(itemData, createElement) {
    const container = createElement('div', 'slide-content', {}, '');
    const title = createElement('h2', '', {}, itemData.title);
    const description = createElement('p', '', {}, itemData.description);
  
    // Create a container for the activity slider
    const activitySliderContainer = createElement('div', 'activity-slider-container');
  
    // Initialize the ActivitySlider with the activity data
    const activitySlider = new ActivitySlider('.activity-slider-container', itemData.activities, this.createItemContent);
  
    container.append(title, description, activitySliderContainer);
    return container;
  }

 
    AboutProgramContainer(data) {
      if(data[0]){
        let introx = document.querySelector('main #program-intro');
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

export default ProgramView;