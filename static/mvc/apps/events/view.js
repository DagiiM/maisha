import View from '../../vitals/views/view.js';
import getImageUrl from '../../vitals/utils/image_version.js';
import { ContentSlider } from '../../vitals/components/content-slider.js';
import { Lightbox } from '../../vitals/components/light-box.js';


import { ActivitySlider } from './components/activity_slider.js';

class EventView extends View{
    constructor(eventsystem){
        super(eventsystem);

        this.endpoints = {
            ...this.endpoints,
            event : {
                  url : 'api/events/',
                  method : 'fetch',
                  containerMethod : this.EventContainer.bind(this),
              },
              
            };
    }



    EventContainer(data) {
        const events = data.results;

        console.log(events)
        this.displayEvents(events);
      
      }

      createEventCard(event) {
        const container = document.createElement('div');
        container.className = 'eleso-container-card';

        const card = document.createElement('div');
        card.className = 'eleso-card';

        const cardHeader = document.createElement('div');
        cardHeader.className = 'eleso-card-header';

        const date = document.createElement('div');
        date.className = 'eleso-card-header__date';
        date.textContent = new Date(event.start_date).toLocaleDateString('en-US', {
            month: 'long',
            day: 'numeric',
            year: 'numeric'
        });

        const image = document.createElement('img');
        image.src = event.image.versions.thumbnail;
        image.alt = event.image.caption;
        image.className = 'event-image';

        const title = document.createElement('div');
        title.className = 'eleso-card-header__title';
        const h2 = document.createElement('h2');
        h2.textContent = event.title;
        title.appendChild(h2);

        const cardContent = document.createElement('div');
        cardContent.className = 'eleso-card-content';
        const description = document.createElement('p');
        description.textContent = event.description;
        cardContent.appendChild(description);

        cardHeader.appendChild(date);
        cardHeader.appendChild(image);
        cardHeader.appendChild(title);
        card.appendChild(cardHeader);
        card.appendChild(cardContent);

        const cardDetails = document.createElement('div');
        cardDetails.className = 'eleso-card-details';
        cardDetails.style.backgroundImage = `url('${event.image.versions.thumbnail}')`;

        const detailsTitle = document.createElement('h2');
        detailsTitle.textContent = event.title;
        cardDetails.appendChild(detailsTitle);

        const table = document.createElement('table');
        table.className = 'details-table';

        const dateRow = document.createElement('tr');
        const dateCell1 = document.createElement('td');
        dateCell1.innerHTML = '<strong>Date:</strong>';
        const dateCell2 = document.createElement('td');
        dateCell2.textContent = new Date(event.start_date).toLocaleDateString('en-US', {
            month: 'long',
            day: 'numeric',
            year: 'numeric'
        });
        dateRow.appendChild(dateCell1);
        dateRow.appendChild(dateCell2);

        const locationRow = document.createElement('tr');
        const locationCell1 = document.createElement('td');
        locationCell1.innerHTML = '<strong>Location:</strong>';
        const locationCell2 = document.createElement('td');
        locationCell2.textContent = event.location;
        locationRow.appendChild(locationCell1);
        locationRow.appendChild(locationCell2);

        const priceRow = document.createElement('tr');
        const priceCell1 = document.createElement('td');
        priceCell1.innerHTML = '<strong>Price:</strong>';
        const priceCell2 = document.createElement('td');
        priceCell2.textContent = '$5 in advance, $15 at the door';
        priceRow.appendChild(priceCell1);
        priceRow.appendChild(priceCell2);

        table.appendChild(dateRow);
        table.appendChild(locationRow);
        table.appendChild(priceRow);

        const button = document.createElement('button');
        button.className = 'purchase-button';
        button.textContent = 'PURCHASE TICKETS';

        cardDetails.appendChild(table);
        cardDetails.appendChild(button);

        container.appendChild(card);
        container.appendChild(cardDetails);

        return container;
    }

    displayEvents(events) {
        const eventsContainer = document.getElementById('events-container');
        events.results.forEach(event => {
            const eventCard = this.createEventCard(event);
            eventsContainer.appendChild(eventCard);
        });
    }

  
  
}

export default EventView;