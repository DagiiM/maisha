import View from '../../vitals/views/view.js';

class OrganizationView extends View{
    constructor(eventsystem){
        super(eventsystem);
        this.container = document.querySelector('.eleso-container-noshadow');

        this.endpoints = {
            ...this.endpoints,
            blogs : {
                url : 'api/recent-verified-about-organization/',
                method : 'fetch',
                containerMethod : this.organization.bind(this),
            }
            
          };
    }

    organization(data) {
        if(data[0]){
            this.container.innerHTML = data[0].content;
        }
        else{
            console.log('No About Organization Content Yet')
        }

    }
}

export default OrganizationView;