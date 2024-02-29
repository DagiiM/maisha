import View from '../../vitals/views/view.js';

class FooterView extends View{
    constructor(eventsystem){
        super(eventsystem);
        this.container = document.querySelector('.footer-contact-card');
    }

    endpoints = {
        organizations : {
            url : 'api/organizations/',
            method : 'fetch',
            containerMethod : this.contact.bind(this),
        }
        
      };

      contact(data) {
        let organization  = data.results[0];

        this.organizationContactInfo(organization);

    }

      organizationContactInfo = (organization) => {
        const organizationContainer = this.container;
    
        // Create a container for the card
        const cardContainer = document.createElement("div");
        cardContainer.classList.add("eleso-organization-card");
    
        const name = document.createElement("div");
        name.classList.add("eleso-organization-card__name");
    
        const email = document.createElement("div");
        email.classList.add("eleso-organization-card__email");
    
        const logo = document.createElement("div");
        logo.classList.add("eleso-organization-card__logo");
    
        const image = document.createElement("img");
        image.src = organization.logo.image;
        image.classList.add("eleso-organization-card__logo-image");
        logo.appendChild(image);
    
        const address = document.createElement("div");
        address.classList.add("eleso-organization-card__address");
    
        const phone = document.createElement("div");
        phone.classList.add("eleso-organization-card__phone");
    
        name.textContent = organization.name;
        email.innerHTML = `<i class="icon-email"></i> : ${organization.contact_info.email}`;
        address.innerHTML = `<i class="icon-map"></i> : ${organization.address.postal_code}, State: ${organization.address.state}, City: ${organization.address.city}`;
        phone.innerHTML = `<i class="icon-phone_enabled"></i> : ${organization.contact_info.phone}`;
    
        // Append the elements to the card container
        //cardContainer.appendChild(logo);
        cardContainer.appendChild(name);
        cardContainer.appendChild(email);
        cardContainer.appendChild(address);
        cardContainer.appendChild(phone);
    
        // Append the card container to the organization container
        this.container.appendChild(cardContainer);
    } 
}

export default FooterView;