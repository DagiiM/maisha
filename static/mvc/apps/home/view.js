import View from '../../vitals/views/view.js';
import {createCarouselComponent} from '../../vitals/components/carousel.js';
import ColorGenerator from '../../vitals/components/color.js';
import getImageUrl from '../../vitals/utils/image_version.js';
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
            
        howItWorks : {
          url : 'api/organization-steps/',
          method : 'fetch',
          containerMethod : this.createHowItWorksSection.bind(this),
      }
      };
    }


      QuotesContainer(data){
        createCarouselComponent(document.querySelector(".slider-quote"), data.results, 'quote')
      }

      TeamContainer(data){
        const xdata = data.results
        const mini_container = document.querySelector(".team-section")
        const parentElement = document.querySelector('.team-container');

        // Create a title for the section
        const sectionTitle = document.createElement('h3');
        sectionTitle.textContent = 'Our Awesome Team';
        sectionTitle.classList.add('eleso-font-executive','eleso-font-gradient-shine','eleso-text-center','eleso-mtb-4');

        // Iterate through each team member in the results array
        xdata.forEach(member => {
          // Create a div for each team member
          const teamMemberDiv = document.createElement('div');
          teamMemberDiv.classList.add('eleso-grid-item','box-shadow', 'eleso-border-round', 'eleso-border-2', 'eleso-mb-2', 'eleso-bg-white', 'eleso-hover-link-icon');
          teamMemberDiv.style='display:flex;flex-direction:column';
          const teamMemberDescDiv = document.createElement('div');
          teamMemberDescDiv.classList.add('eleso-p-2');

          // Create an img element for the profile picture
          const profileImg = document.createElement('img');
          profileImg.classList.add('eleso-image')
          profileImg.setAttribute('loading', 'lazy');
          profileImg.src = getImageUrl(member.image.versions);
          profileImg.alt = `${member.user.first_name} ${member.user.last_name}`;
          

          // Create a div for the role
          const userDiv = document.createElement('div');
          userDiv.classList.add('eleso-font-subtle')
          userDiv.textContent = `${member.user.first_name} ${member.user.last_name}`;

          // Create a div for the role
          const roleDiv = document.createElement('div');
          roleDiv.classList.add('eleso-font-casual')
          roleDiv.textContent = `${member.role}`;

          // Create a div for the contact info
          const contactInfoDiv = document.createElement('div');
          contactInfoDiv.classList.add('eleso-font-subtle')
          contactInfoDiv.textContent = `${member.contact_info.email}`;

          // Append the elements to the teamMemberDiv
          teamMemberDiv.appendChild(profileImg);
          teamMemberDescDiv.append(userDiv,roleDiv);
          teamMemberDescDiv.appendChild(contactInfoDiv);
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
        const mini_container = document.querySelector(".partner-section")
        // Create a container for the Maisha Partners section
        const maishaSection = document.createElement('section');
        maishaSection.classList.add('maisha-partners-section');

        // Create a container for the partners
        const partnerContainer = this.createPartnerContainer(data);
      
        // Append the partner container to the Maisha Partners section
        maishaSection.appendChild(partnerContainer);
        
        mini_container.appendChild(maishaSection);
       
        return maishaSection;
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
          card.classList.add('eleso-grid-item','eleso-p-3','eleso-mtb-2','eleso-font-subtle','eleso-border-round','eleso-box-shadow','eleso-theme-secondary-light');
      
          // Get the background color of the container
          //const containerStyles = getComputedStyle(container);
          //const containerBgColor = containerStyles.backgroundColor;

          // Generate a random color for the card title
          //const colorGenerator = new ColorGenerator();

          //const titleColor = colorGenerator.getRandomColor(containerBgColor);
          const description = document.createElement('p');
          description.innerHTML = `${item.description}`;
      
          const title = document.createElement('h4');
          title.classList.add('eleso-font-casual','eleso-p-2')
          title.innerHTML = `${item.title}`;

          //const backgroundColor = colorGenerator.generateRandomContrastingColor();
          //ard.style.backgroundColor = backgroundColor;
          //card.style.color = colorGenerator.getContrastingColor(containerBgColor);
      
          // Set a unique border color for each card
          //card.style.borderColor = card.style.color;

          card.append(description, title);
          section.appendChild(card);
      });

        container.appendChild(section)

      }
    
    
      
      createPartnerContainer(data) {
        const results = data.results;
      
        // Create a container element for the partners
        const container = document.querySelector('.partner-section .eleso-grid-container');

        // Loop through the results and create a card for each partner
        results.forEach(partner => {
          // Create a card element
          const card = document.querySelector('.partner-section .eleso-grid-container .eleso-grid-item');
      
          // Create an image element for the logo
          const logoImg = document.createElement('img');
          logoImg.src = getImageUrl(partner.logo.versions); // Replace with your actual image URL
          logoImg.setAttribute('loading', 'lazy');
          logoImg.classList.add('eleso-image-logo','eleso-m-3');
          logoImg.alt = partner.company_name;
      
          // Append the image and company name to the card
          card.appendChild(logoImg);
      
          // Append the card to the container
          //container.appendChild(card);
        });
      
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