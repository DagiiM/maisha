import View from '../../vitals/views/view.js';

class ContactView extends View{
    constructor(eventsystem){
        super(eventsystem);
        //this.container = document.querySelector('#officeContainer');

        this.endpoints = {
            ...this.endpoints,
            organizations : {
                url : 'api/organizations/',
                method : 'fetch',
                containerMethod : this.contact.bind(this),
            }
            
          };
    }



    contact(data) {
        let organization  = data.results[0];

        this.Newsletter();
        this.organizationContactInfo(organization);

    }

    organizationContactInfo = (organization) => {
        const organizationContainer = document.getElementsByClassName("eleso-organization-contact");
    
        // Create a container for the card
        const cardContainer = document.createElement("div");
        cardContainer.classList.add("eleso-organization-card");
    
        const name = document.createElement("div");
        name.classList.add("eleso-organization-card__name",'eleso-font-highlight','eleso-text-brand');
    
        const email = document.createElement("div");
        email.classList.add("eleso-organization-card__email",'eleso-flex','eleso-p-2');
    
        if(organization.image){
            const logo = document.createElement("div");
            logo.classList.add("eleso-organization-card__logo");
        
            const image = document.createElement("img");
            image.src = organization.image.image;
            image.classList.add("eleso-organization-card__logo-image");
            logo.appendChild(image);
        }
    
        const address = document.createElement("div");
        address.classList.add("eleso-organization-card__address",'eleso-flex','eleso-p-2');
    
        const phone = document.createElement("div");
        phone.classList.add("eleso-organization-card__phone",'eleso-flex','eleso-p-2');
    
        name.textContent = organization.name;
        email.innerHTML = `<i class="icon-email"></i> : <p>${organization.contact_info.email}</p>`;
        address.innerHTML = `<i class="icon-map"></i> : <p>${organization.address.postal_code}, State: ${organization.address.state}, City: ${organization.address.city} </p>`;
        phone.innerHTML = `<i class="icon-phone_enabled"></i> : <p>${organization.contact_info.phone}</p>`;
    
        // Append the elements to the card container
        //cardContainer.appendChild(logo);
        cardContainer.appendChild(name);
        cardContainer.appendChild(email);
        cardContainer.appendChild(address);
        cardContainer.appendChild(phone);
    
        // Append the card container to the organization container
        organizationContainer[0].appendChild(cardContainer);
    } 

    Newsletter = ()=>{
        // Create form elements using JavaScript
        const form = document.getElementById("subscribe-form");
        form.classList.add('subscribe-form__fancy');
        const nameLabel = document.createElement("label");
        nameLabel.textContent = "Full Name";
        const nameInput = document.createElement("input");
        nameInput.setAttribute("type", "text");
        nameInput.setAttribute("name", "name");
        nameInput.setAttribute("placeholder", "Full Name");
        nameInput.required = true;
        nameInput.classList.add("eleso-input");
    
        const emailLabel = document.createElement("label");
        emailLabel.textContent = "Email Address";
        const emailInput = document.createElement("input");
        emailInput.setAttribute("type", "email");
        emailInput.setAttribute("name", "email");
        emailInput.setAttribute("placeholder", "Email Address");
        emailInput.required = true;
        emailInput.classList.add("eleso-input");
    
        const messageLabel = document.createElement("label");
        messageLabel.textContent = "Message";
        const messageTextarea = document.createElement("textarea");
        messageTextarea.setAttribute("name", "message");
        messageTextarea.setAttribute("placeholder", "Message");
        messageTextarea.rows = 4;
        messageTextarea.classList.add("eleso-input", "eleso-input--textarea");
    
        const subscribedLabel = document.createElement("label");
        subscribedLabel.textContent = "Subscribe to Newsletter";
        subscribedLabel.classList.add('eleso-p-inline-2')
        const subscribedCheckboxContainer = document.createElement("div");
        subscribedCheckboxContainer.classList.add("eleso-checkbox-label",'eleso-flex','eleso-align-items-center');
        const subscribedCheckbox = document.createElement("input");
        subscribedCheckbox.setAttribute("type", "checkbox");
        subscribedCheckbox.setAttribute("name", "subscribed");
        subscribedCheckbox.value = "on";
        subscribedCheckbox.id = "id_subscribed";
        subscribedCheckbox.classList.add("eleso-checkbox",'eleso-p-2');
    
        const submitButton = document.createElement("input");
        submitButton.setAttribute("type", "submit");
        submitButton.setAttribute("value", "Subscribe");
        submitButton.classList.add("eleso-button",'eleso-mtb-3','eleso-border-round');
    
        // Append form elements to the form
        form.appendChild(nameLabel);
        form.appendChild(nameInput);
        form.appendChild(emailLabel);
        form.appendChild(emailInput);
        form.appendChild(messageLabel);
        form.appendChild(messageTextarea);
    
        subscribedCheckboxContainer.appendChild(subscribedCheckbox);
        subscribedCheckboxContainer.appendChild(subscribedLabel);
        form.appendChild(subscribedCheckboxContainer);
    
        form.appendChild(submitButton);
        }
}

export default ContactView;