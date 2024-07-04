import View from '../../vitals/views/view.js';
//import {createCarouselComponent} from '../../vitals/components/carousel.js';
import { corporateCarousel } from '../../vitals/components/corporate-carousel.js';
import { ContentSlider } from '../../vitals/components/content-slider.js';
import { Lightbox } from '../../vitals/components/light-box.js';

class DesignView extends View{
    constructor(eventsystem){
        super(eventsystem);
        //this.container = document.querySelector('#officeContainer');

        this.endpoints = {
            ...this.endpoints,
            images : {
                url : 'api/images/featured_images',
                method : 'fetch',
                containerMethod : this.getCarouselContainer.bind(this),
            },

            activity : {
                url : 'api/activities',
                method : 'fetch',
                containerMethod : this.createSliderContent.bind(this),
            },
            
          };
    }


    getCarouselContainer(data) {
        new corporateCarousel(data);
      }

    createSliderContent(data) {

        let activities = data.results;
        const sliderContainer = document.querySelector('.eleso-slider');
        const contentSliderElement = document.createElement('div');
        contentSliderElement.classList.add('eleso-content-slider');

        activities.forEach((result) => {
          let item = document.createElement('article');
          item.classList.add('eleso-slide', 'eleso-m-2', 'eleso-p-1');
      
          // Create the slide content
          let slideContent = document.createElement('div');
          slideContent.classList.add('slide-content');
      
          // Add the title
          let title = document.createElement('h2');
          title.textContent = result.title;
      
          // Add the description
          let description = document.createElement('p');
          description.textContent = result.description;
          description.classList.add('description');
      
          // Add the "Show More/Less" button
          let showMoreButton = document.createElement('button');
          showMoreButton.classList.add('show-more-button');
          showMoreButton.textContent = 'Show More';
          showMoreButton.addEventListener('click', () => {
            description.classList.toggle('expanded');
            showMoreButton.textContent = description.classList.contains('expanded') ? 'Show Less' : 'Show More';
          });
      
          // Set the background image
          item.style.backgroundImage = `url(${result.image.file})`;
          item.style.backgroundSize = 'cover';
          item.style.backgroundPosition = 'center';
      
          /*
          // Add the lightbox trigger
          let lightboxTrigger = document.createElement('a');
          lightboxTrigger.href = result.image.file;
          lightboxTrigger.classList.add('eleso-slide', 'lightbox-trigger');
          lightboxTrigger.setAttribute('data-lightbox-id', `lightbox-${result.title.replace(/\s/g, '-')}`);
          lightboxTrigger.appendChild(slideContent);
          */
      
          // Append the elements to the slide content
          slideContent.appendChild(title);
          slideContent.appendChild(description);
          slideContent.appendChild(showMoreButton);
          item.appendChild(slideContent);
          // Append the lightbox trigger to the contentSliderElement
          contentSliderElement.appendChild(item);
        });
        const lightbox = new Lightbox();
        sliderContainer.appendChild(contentSliderElement);
 
        const optionsSlider = new ContentSlider(sliderContainer, {
          customOffset: 1,
          initialSlide: 0,
          autoSlide: true,
          autoSlideDelay: 5000,
          transitionDuration: 1000,
          loop: true,
          navigation: true,
          pagination: true,
          touchSwipe: true,
          responsive: true
        });

        return optionsSlider
      }
    


            
        
}

export default DesignView;