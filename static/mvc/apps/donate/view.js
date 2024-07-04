import View from '../../vitals/views/view.js';
import {createCarouselComponent} from '../../vitals/components/carousel.js';

class DonateView extends View{
    constructor(eventsystem){
        super(eventsystem);
        this.container = document.querySelector('.eleso-organization-contact');
      /*
        this.endpoints = {
          ...this.endpoints,
            quotes : {
                url : 'api/quotes/',
                method : 'fetch',
                containerMethod : this.QuotesContainer.bind(this),
            }
            
          };
          */
    }

      QuotesContainer(data){
        createCarouselComponent(this.container, data.results, 'quote')
      }

}

export default DonateView;