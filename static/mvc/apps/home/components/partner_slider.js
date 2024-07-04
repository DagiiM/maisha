import getImageUrl from '../../vitals/utils/image_version.js';
import { Component } from '../../vitals/components/component.js';
import { ContentSlider } from '../../vitals/components/content-slider.js';

class PartnerSlider extends Component {
    constructor(selector, data, createItemContentFn) {
        super();
        this.container = document.querySelector(selector);
        this.data = data;
        this.createItemContentFn = createItemContentFn;
        this.sliderElement = this.createSliderContainer();
        this.initSlider();
    }

    createSliderContainer() {
        const sliderContainer = this.createElement('div', 'eleso-content-slider');
        sliderContainer.setAttribute('aria-live', 'polite');
        sliderContainer.setAttribute('role', 'region');
        sliderContainer.setAttribute('aria-label', 'Dynamic Content Slider');
        return sliderContainer;
    }

    createSlide(itemData) {
        const slide = this.createElement('article', 'eleso-slide eleso-m-2 eleso-p-1');
        slide.setAttribute('role', 'group');
        slide.setAttribute('aria-roledescription', 'slide');
        slide.style.backgroundImage = `url(${getImageUrl(itemData.image.versions)})`;
        slide.style.backgroundSize = 'cover';
        slide.style.backgroundPosition = 'center';

        const slideContent = this.createItemContentFn(itemData, this.createElement.bind(this));
        slide.appendChild(slideContent);

        let description = slideContent.querySelector('p');
        description.classList.add('description');

        // Create Show More/Show Less button and bind event
        let showMoreButton = document.createElement('button');
        showMoreButton.classList.add('show-more-button');
        showMoreButton.textContent = 'Show More';
        showMoreButton.addEventListener('click', () => {
          description.classList.toggle('expanded');
          showMoreButton.textContent = description.classList.contains('expanded') ? 'Show Less' : 'Show More';
        });
        slideContent.appendChild(showMoreButton);
        return slide;
    }


    initSlider() {
        this.data.forEach(item => {
            const slide = this.createSlide(item);
            this.sliderElement.appendChild(slide);
        });
        this.container.appendChild(this.sliderElement);
        this.activateSlider();
    }

    activateSlider() {
        new ContentSlider(this.container, this.getSliderOptions());
    }

    getSliderOptions() {
        return {
            customOffset: 1,
            initialSlide: 0,
            autoSlide: true,
            autoSlideDelay: 9000,
            transitionDuration: 8000,
            loop: true,
            navigation: false,
            pagination: true,
            touchSwipe: true,
            responsive: true
        };
    }
}

export { PartnerSlider };
