import View from '../../vitals/views/view.js';
import getImageUrl from '../../vitals/utils/image_version.js';

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
            let p = document.querySelector('main #maisha-intro .about-maisha');
            let image = document.querySelector('main #maisha-intro .about-maisha-image');
            
            p.innerHTML=`${data[0].content || 'No About Maisha Content Yet'}`
     
            if (data[0].image){
              image.src = `${getImageUrl(data[0].image.versions)}`;
              image.alt = `${data[0].image.caption}`;
            }
          }

    }
}

export default OrganizationView;