import View from '../../vitals/views/view.js';

class AboutView extends View{
    constructor(eventsystem){
        super(eventsystem);
        this.container = document.querySelector('.eleso-container-noshadow');

        this.endpoints = {
            ...this.endpoints,
            about : {
                url : 'api/recent-verified-about-us/',
                method : 'fetch',
                containerMethod : this.about.bind(this),
            },
    
            howItWorks : {
                url : 'api/organization-steps/',
                method : 'fetch',
                containerMethod : this.createHowItWorksSection.bind(this),
            }
            
          };
          
    }


    about(data) {
        if(this.container){
            this.container.innerHTML = data[0].content || 'No About Us Content Yet';
        }
      
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
          card.classList.add('eleso-grid-item','eleso-theme-secondary-lighter','eleso-p-3','eleso-mtb-2','eleso-font-subtle','eleso-border-round','eleso-box-shadow');
      
          // Get the background color of the container
          const containerStyles = getComputedStyle(container);
          const containerBgColor = containerStyles.backgroundColor;

          // Generate a random color for the card title
          //const colorGenerator = new ColorGenerator();

          //const titleColor = colorGenerator.getRandomColor(containerBgColor);
          const description = document.createElement('p');
          description.classList.add('eleso-font-subtle')
          description.innerHTML = `${item.description}`;
      
          const title = document.createElement('h4');
          title.classList.add('eleso-font-casual','eleso-p-2')
          title.innerHTML = `${item.title}`;

         // const backgroundColor = colorGenerator.generateRandomContrastingColor();
          //card.style.backgroundColor = backgroundColor;
          //card.style.color = colorGenerator.getContrastingColor(containerBgColor);
      
          // Set a unique border color for each card
          //card.style.borderColor = card.style.color;

          card.append(description, title);
          section.appendChild(card);
      });

        container.appendChild(section)

      }
}

export default AboutView;