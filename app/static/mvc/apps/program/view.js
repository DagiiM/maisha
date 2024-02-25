import View from '../../vitals/views/view.js';
import getImageUrl from '../../vitals/utils/image_version.js';

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

   /*
    ProgramContainer(data) {
        const programs = data.results;
      
        programs.forEach(program => {
          // Create HTML element for the program section
          const programSection = document.createElement('article');
          programSection.classList.add('eleso-theme-secondary-lighter', 'eleso-grid-item', 'eleso-box-shadow', 'eleso-border-round', 'eleso-border-2', 'eleso-mb-2', 'eleso-bg-white', 'eleso-hover-link-icon');
          programSection.id = `program-${program.id}`; // Unique ID for scrolling
      
          // Add program content
          programSection.innerHTML = `
            <div class="eleso-p-2">
              <h2 class="eleso-font-executive">${program.title}</h2>
              <p class="eleso-font-subtle eleso-pt-1">${program.description}</p>
              <a href="#activities" class="eleso-font-bold eleso-text-black eleso-link eleso-mtb-2 eleso-flex-button"><span class="eleso-mr-1">Read More</span> <i class="icon-arrow_right_alt eleso-ml-1 eleso-font-size-4 eleso-text-brand"></i></a>
            </div>
          `;
      
          // Create activities container within the program section
          const activityContainer = document.getElementById('activities');
      
          // Loop through program's activities and create cards
          program.activities.forEach(activity => {
            const activityCard = this.createActivityCard(activity, program.id);
            activityContainer.appendChild(activityCard);
          });

          // Append activities container to program section
          
          activityContainer.appendChild(activitiesContainer);
      
          // Append program section to the main container
          const programContainer = document.getElementById('program-container');
          programContainer.appendChild(programSection);
        });
      }
      

      
*/

ProgramContainer(data) {
    const programs = data.results;
    const activitiesContainer = document.getElementById('activities');
  
    // Initially clear the activities container
    activitiesContainer.innerHTML = '';
  
    programs.forEach(program => {
      // Create HTML element for the program section
      const programSection = document.createElement('article');
      programSection.classList.add('eleso-theme-secondary-lighter', 'eleso-grid-item', 'eleso-box-shadow', 'eleso-border-round', 'eleso-border-2', 'eleso-mb-2', 'eleso-bg-white', 'eleso-hover-link-icon');
      programSection.id = `program-${program.id}`; // Unique ID for scrolling
  
      // Add program content
      programSection.innerHTML = `
        <div class="eleso-p-2">
          <h2 class="eleso-font-executive">${program.title}</h2>
          <p class="eleso-font-subtle eleso-pt-1">${program.description}</p>
          <a href="#activities" class="eleso-font-bold eleso-text-black eleso-link eleso-mtb-2 eleso-flex-button"><span class="eleso-mr-1">Read More</span> <i class="icon-arrow_right_alt eleso-ml-1 eleso-font-size-4 eleso-text-brand"></i></a>
        </div>
      `;
  
      // Handle click event on "Read More" button
      const readMoreButton = programSection.querySelector('.eleso-flex-button');
      readMoreButton.addEventListener('click', (event) => {
        event.preventDefault(); // Prevent default link behavior
  
        // Clear existing activities for this program
        const programActivitiesContainer = activitiesContainer.querySelector(`#activities-container-${program.id}`);
        if (programActivitiesContainer) {
          programActivitiesContainer.innerHTML = '';
        }else {
            const newActivitiesContainer = document.createElement('article');
            newActivitiesContainer.id = `activities-container-${program.id}`;
            newActivitiesContainer.classList.add('eleso-grid-container','eleso-ptb-3','eleso-p-inline-4','eleso-p-1')
            activitiesContainer.appendChild(newActivitiesContainer);
          }
          
        // Loop through program's activities and create cards
        program.activities.forEach(activity => {
          const activityCard = this.createActivityCard(activity, program.id);
          programActivitiesContainer.appendChild(activityCard);
        });
  
  
        // Scroll to the activities container (adjust as needed)
        programActivitiesContainer.scrollIntoView({ behavior: 'smooth' });
      });
  
      // Append program section to the main container
      const programContainer = document.getElementById('program-container');
      programContainer.appendChild(programSection);
    });
  }

  createActivityCard(activity, programId) {
    const cardElement = document.createElement('article');
    cardElement.classList.add('eleso-theme-secondary-lighter', 'eleso-grid-item', 'eleso-box-shadow', 'eleso-border-round', 'eleso-border-2', 'eleso-mb-2', 'eleso-bg-white', 'eleso-hover-link-icon');
    cardElement.id = `activity-${programId}-${activity.id}`; // Unique ID for scrolling
  
    cardElement.innerHTML = `
      <img src="${getImageUrl(activity.image.versions)}" alt="${activity.image.caption}" class="eleso-thumbnail-img eleso-br-2" loading="lazy">
      <div class="eleso-p-2">
        <h2 class="eleso-font-executive">${activity.title}</h2>
        <p class="eleso-font-subtle eleso-pt-1">${activity.description}</p>
      </div>
    `;
  
    return cardElement;
  }

  scrollToActivity(activitySectionId) {
    // Extract program ID from section ID
    const programId = activitySectionId.split('-')[1];
  
    // Find the program container element
    const programContainer = document.getElementById(`program-${programId}`);
  
    // Find the activity section element within the program container
    const activityElement = programContainer.querySelector(`#${activitySectionId}`);
  
    // Scroll to the activity section
    activityElement.scrollIntoView({ behavior: 'smooth' });
  }
  
    AboutProgramContainer(data) {
      if(data[0]){
        let p = document.querySelector('main #program-intro > p');
        p.innerHTML=`${data[0].content || 'No About Us Content Yet'}`
      }
    }
}

export default ProgramView;