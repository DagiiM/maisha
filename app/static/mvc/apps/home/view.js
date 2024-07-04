import View from '../../vitals/views/view.js';
import {createCarouselComponent} from '../../vitals/components/carousel.js';
import ColorGenerator from '../../vitals/components/color.js';
import getImageUrl from '../../vitals/utils/image_version.js';

import { corporateCarousel } from '../../vitals/components/corporate-carousel.js';
import { ContentSlider } from '../../vitals/components/content-slider.js';
import { Lightbox } from '../../vitals/components/light-box.js';

import { ActivitySlider } from './components/activity_slider.js';
import { EventSlider } from './components/event_slider.js';

class HomeView extends View{
    constructor(eventsystem){
        super(eventsystem);
        this.container = document.querySelector(".home-page");

        this.endpoints = {
          ...this.endpoints,
            images : {
                url : 'api/images/featured_images',
                method : 'fetch',
                containerMethod : this.getCarouselContainer.bind(this),
            },
            
            partners : {
                url : 'api/partners/',
                method : 'fetch',
                containerMethod : this.createMaishaPartnersSection.bind(this)
            },
            about_partners : {
              url : 'api/recent-verified-about-partners/',
              method : 'fetch',
              containerMethod : this.createMaishaPartnersAboutSection.bind(this)
          },
  
            quotes : {
              url : 'api/quotes/',
              method : 'fetch',
              containerMethod : this.QuotesContainer.bind(this),
          },
        
          team : {
            url : 'api/team/',
            method : 'fetch',
            containerMethod : this.TeamContainer.bind(this),
        },            
        event : {
          url : 'api/events',
          method : 'fetch',
          containerMethod : this.getEventContainer.bind(this),
      },
        activity : {
          url : 'api/activities',
          method : 'fetch',
          containerMethod : this.getActivitySlider.bind(this),
      },   
        howItWorks : {
          url : 'api/organization-steps/',
          method : 'fetch',
          containerMethod : this.createHowItWorksSection.bind(this),
      }
      };
    }

  
    createEventCard(event,createElement) {
      const container = this.createElement('div','eleso-container-card');
      const card = this.createElement('div','eleso-card');
      const cardHeader = this.createElement('div','eleso-card-header');
      const date = this.createElement('div','eleso-card-header__date');
      
      date.textContent = new Date(event.start_date).toLocaleDateString('en-US', {
          month: 'long',
          day: 'numeric',
          year: 'numeric'
      });

      const image = this.createElement('img','event-image');
      image.src = event.image.versions.thumbnail;
      image.alt = event.image.caption;

      const title = this.createElement('div','eleso-card-header__title');
      const h3 =  this.createElement('h3','eleso-aligned-image-block__title eleso-font-executive');
      h3.textContent = event.title;
      title.appendChild(h3);

      const cardContent = this.createElement('div','eleso-card-content');
      const description = this.createElement('p','eleso-content-card__body eleso-content-card__body--truncated');
      description.textContent = event.description;
      
      //cardContent.append(image, title, description);

      const showMoreButton = this.createElement('button','show-more-button');
      const showLessButton = this.createElement('button','show-less-button');

      showMoreButton.innerHTML = '<i class="icon-info_outline"></i>';
      showLessButton.textContent = 'x';
      
      showMoreButton.addEventListener('click', () => {
          card.classList.add('hidden');
          cardDetails.classList.add('show');
      });

      showLessButton.addEventListener('click', () => {
          card.classList.remove('hidden');
          cardDetails.classList.remove('show');
      });

      cardHeader.appendChild(date);
      cardHeader.appendChild(image);
      //cardHeader.appendChild(title);
      //card.appendChild(cardHeader);
      card.append(date, image, title, description);
      card.appendChild(showMoreButton);

      const cardDetails = document.createElement('div');
      cardDetails.className = 'eleso-card-details hidden';
      cardDetails.style.backgroundImage = `url('${event.image.versions.thumbnail}')`;

      const detailsTitle = document.createElement('h2');
      detailsTitle.textContent = event.title;
      cardDetails.appendChild(detailsTitle);
      cardDetails.appendChild(showLessButton);

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

      const purchaseButton = document.createElement('button');
      purchaseButton.className = 'purchase-button';
      purchaseButton.textContent = 'Book A Sit';

      cardDetails.appendChild(table);
      cardDetails.appendChild(purchaseButton);

      container.appendChild(card);
      container.appendChild(cardDetails);

      return container;
  }
  
    getEventContainer(data){
      data = data.results;
     let container = document.querySelector('#events-container');
    new EventSlider(container, data, this.createEventCard);
  }
     
      QuotesContainer(data){
        //createCarouselComponent(document.querySelector(".slider-quote"), data.results, 'quote')
      }

      TeamContainer(data){
        const xdata = data.results
        const mini_container = document.querySelector(".team-section")
        const parentElement = document.querySelector('.team-container');

        // Create a title for the section
        const sectionTitle = document.createElement('h3');
        sectionTitle.textContent = 'Our Awesome Team';
        sectionTitle.classList.add('eleso-font-fancy','eleso-text-left','eleso-mtb-4','eleso-p-inline-4');

        // Iterate through each team member in the results array
        xdata.forEach(member => {
          // Create a div for each team member
          const teamMemberDiv = document.createElement('div');
          teamMemberDiv.classList.add('eleso-grid-item','box-shadow', 'eleso-border-round', 'eleso-border-2', 'eleso-mb-2');
          teamMemberDiv.style='display:flex;flex-direction:column';
          const teamMemberDescDiv = document.createElement('div');
          teamMemberDescDiv.classList.add('eleso-p-2','eleso-text-left');

          if(member.image){
              // Create an img element for the profile picture
              const profileImg = document.createElement('img');
              profileImg.classList.add('eleso-image')
              profileImg.setAttribute('loading', 'lazy');
              profileImg.src = `${member.image.versions.thumbnail}`;
              profileImg.alt = `${member.user.first_name} ${member.user.last_name}`;
              teamMemberDiv.appendChild(profileImg);  
          }

          // Create a div for the role
          const userDiv = document.createElement('div');
          userDiv.classList.add('eleso-font-regular')
          userDiv.textContent = `${member.user.first_name} ${member.user.last_name}`;

          // Create a div for the role
          const roleDiv = document.createElement('div');
          roleDiv.classList.add('eleso-font-regular','eleso-font-bold')
          roleDiv.textContent = `${member.role}`;

        if(member.contact_info){
          // Create a div for the contact info
          const contactInfoDiv = document.createElement('div');
          contactInfoDiv.classList.add('eleso-font-regular')
          contactInfoDiv.textContent = `${member.contact_info.email}`;
          teamMemberDescDiv.appendChild(contactInfoDiv);
        }

          // Append the elements to the teamMemberDiv

          teamMemberDescDiv.append(userDiv,roleDiv);
          teamMemberDiv.appendChild(teamMemberDescDiv);

          // Append the teamMemberDiv to the parent element
          parentElement.appendChild(teamMemberDiv);
        });
        mini_container.appendChild(sectionTitle)
        mini_container.appendChild(parentElement)
      }

       getCarouselContainer(data) {
        const carousel = document.querySelector(".slider-images");
        const newElement = document.createElement('div')

        createCarouselComponent(newElement,data.results);

        carousel.appendChild(newElement);
        return newElement;
      }

      createMaishaPartnersSection(data) {
        // const mini_container = document.querySelector(".partner-section")
        // Create a container for the Maisha Partners section
        const maishaSection = document.querySelector('.partner-section__partners');

        // Create a container for the partners
        const partnerContainer = this.createPartnerContainer(data,maishaSection);
      
        // Append the partner container to the Maisha Partners section
        // maishaSection.appendChild(partnerContainer);
        
        // mini_container.appendChild(maishaSection);
       
        return partnerContainer;
      }

      createHowItWorksSection(data){
        const result = data.results

        const container = document.querySelector('.how-it-works-container');
        const h3 = document.createElement('h3');
        h3.classList.add('eleso-font-executive','eleso-text-center','eleso-mt-4','eleso-mb-1','eleso-typing-effect');
        h3.innerHTML = `<span id="text" class="eleso-font-gradient-shine">How It Works</span><span id="cursor">|</span>`;
        container.appendChild(h3);

        const section = document.createElement('div');
        section.classList.add('how-it-works-section','eleso-grid-container','eleso-mb-4','eleso-mt-1','eleso-text-center','eleso-align-center', 'eleso-justify-items-center', 'eleso-p-4');


        result.forEach((item, index) => {
          const card = document.createElement('div');
          card.classList.add('eleso-grid-item','eleso-p-3','eleso-mtb-2','eleso-font-subtle','eleso-border-round','eleso-box-shadow');
          
          // Get the background color of the container
          const containerStyles = getComputedStyle(container);
          const containerBgColor = containerStyles.backgroundColor;

          // Generate a random color for the card title
          const colorGenerator = new ColorGenerator();

          //const titleColor = colorGenerator.getRandomColor(containerBgColor);
          const description = document.createElement('p');
          description.innerHTML = `${item.description}`;
          description.style="padding: 1em 6%;text-align:left"
      
          const title = document.createElement('h4');
          title.classList.add('eleso-p-2','eleso-font-bold','eleso-text-brand')
          title.innerHTML = `${item.title}`;

          const backgroundColor = colorGenerator.generateRandomContrastingColor();
          //card.style.backgroundColor = backgroundColor;
          //title.style.color = colorGenerator.getContrastingColor(backgroundColor);
      
          // Set a unique border color for each card
          card.style.borderColor = backgroundColor;

          card.append(description, title);
          section.appendChild(card);
      });

        container.appendChild(section)

      }

      createItemContent(itemData, createElement) {
        const slider_image = createElement('img', 'slide-image', {}, '');
        slider_image.setAttribute('src',itemData.image.versions.thumbnail);
        slider_image.setAttribute('alt',itemData.image.caption);
        slider_image.setAttribute('loading','lazy');
        
         const container = createElement('div', 'eleso-slider-container-cube', {}, '');
         const slide_content = createElement('div', 'slide-content', {}, '');        
         const title = createElement('h2', 'eleso-font-subtle eleso-text-left', {}, itemData.title);
         const description = createElement('p', 'eleso-font-subtle', {}, itemData.description);
         slide_content.append(title, description)
         container.append(slider_image,slide_content);
         return container;
      };




      generateActivityFeedPost(item) {
        const card = document.createElement('div');
        card.classList.add('eleso-grid-item', 'eleso-mtb-2', 'eleso-font-subtle', 'eleso-soft-box-shadow', 'skeleton');
        card.style = "padding:0";
    
        // Create the header element
        const card_header = document.createElement('div');
        card_header.classList.add('eleso-aligned-image-block__header');
    
        // Create the image element
        const img = document.createElement('img');
        if (item.image) {
            img.src = item.image.versions.medium;
            img.alt = item.image.caption;
        } else {
            img.src = 'path/to/avatar-placeholder.png'; // Use the path to your avatar placeholder
            img.alt = 'Default avatar';
        }
        img.className = 'eleso-image';
        img.loading = 'lazy';
    
        // Create the h3 element
        const h3 = document.createElement('h3');
        h3.className = 'eleso-aligned-image-block__title eleso-font-executive';
        h3.textContent = item.title || 'Default Title';
        h3.style = "--color:var(--theme-primary);";
    
        // Create the div element for the description
        const content_section = document.createElement('div');
        content_section.className = 'eleso-aligned-image-block__content';
    
        const description_section = document.createElement('div');
        description_section.className = "eleso-aligned-image-block__text eleso-list eleso-list--blue";
    
        // Create the paragraph element
        const paragraph = document.createElement('p');
        paragraph.className = "eleso-content-card__body eleso-content-card__body--truncated";
        paragraph.textContent = item.description || 'Default description';
    
        description_section.appendChild(paragraph);
        card_header.appendChild(img);
        content_section.append(h3, description_section);
    
        card.append(card_header, content_section);
    
        // Remove the skeleton class after the content is loaded
        setTimeout(() => card.classList.remove('eleso-skeleton'), 500); // Adjust the timeout as needed
    
        // Return the generated HTML as a string
        return card.outerHTML;
    }
  
  getActivitySlider(data) {
    data = data.results;
    let container = document.querySelector('.program__activity-section');

    // Filter data to include only items with an image
    let itemsWithImage = data.filter(item => item.image);

    // Helper function to get unique random indices
    function getRandomIndices(arr, count) {
        let indices = new Set();
        while (indices.size < count) {
            let randomIndex = Math.floor(Math.random() * arr.length);
            indices.add(randomIndex);
        }
        return Array.from(indices);
    }

    // Check if there are at least three items with images
    if (itemsWithImage.length < 3) {
        console.error("Not enough items with images to select three.");
        return;
    }

    // Get three random items from the filtered data array
    let randomIndices = getRandomIndices(itemsWithImage, 3);
    let randomItems = randomIndices.map(index => itemsWithImage[index]);

    // Generate and append the activity feed posts for the random items
    randomItems.forEach(item => {
        let activity = this.generateActivityFeedPost(item);
        container.innerHTML += activity;
    });
}


      
      createPartnerContainer(data,container) {
        const results = data.results;
      
        // Create a container element for the partners
        //const container = document.querySelector('.partner-section .maisha-partners-section .partner-section__partners');
        const carousel = document.createElement('div');
        carousel.classList.add('eleso-carousel-container');

        const carouselInner = document.createElement('div');
        carouselInner.classList.add('eleso-carousel');

        results.forEach((partner, index) => {
          const carouselItem = document.createElement('div');
          carouselItem.classList.add('eleso-carousel__item');
      
          if(partner.image){
            // Create an image element for the logo
            const logoImg = document.createElement('img');
            logoImg.src = partner.image.versions.thumbnail; // Replace with your actual image URL
            logoImg.setAttribute('loading', 'lazy');
            logoImg.classList.add('eleso-image-logo','eleso-m-1');
            logoImg.alt = partner.company_name;
            carouselItem.appendChild(logoImg);
          }
      
          carouselInner.appendChild(carouselItem);

      });
      carousel.appendChild(carouselInner);
      container.appendChild(carousel)
         
        return container;
      }

      createMaishaPartnersAboutSection(data){
        if(data[0]){
          const mini_container = document.querySelector(".partner-section__about");
          mini_container.innerHTML=data[0].content
        }
      }
      
}

export default HomeView;