import getImageUrl from '../utils/image_version.js'

import {applyStylesFromFile} from '../utils/utils.js';

const CAROUSEL_STYLESHEET = 'carousel';
applyStylesFromFile(CAROUSEL_STYLESHEET);
function createCarouselComponent(carouselContainer, imagesData,contentType='image',bg_color='transparent', autoCycleInterval = 5000) {
    createLoaderElement()
    carouselContainer.classList.add('carousel-container');
    //carouselContainer.style.width = '100%';
    //carouselContainer.style.height = '80vh';

    const carouselImagesContainer = document.createElement('div');
    carouselImagesContainer.classList.add('carousel-image');

    const descriptionsContainer = document.createElement('div');
    descriptionsContainer.classList.add('carousel-descriptions');

    const dotContainer = document.createElement('div');
    dotContainer.classList.add('dot-container');

    carouselContainer.append(descriptionsContainer, carouselImagesContainer, dotContainer);

    let currentImageIndex = 0;
    const images = [];

    function showCurrentImageWithFade() {
        const a = document.querySelectorAll('.loader')
        
        a.forEach((elem,index)=>{
            elem.style.display="none"
        })

        images.forEach((image, index) => {
            if (index === currentImageIndex) {
                image.style.opacity = '1';
                image.style.display = 'block';
            } else {
                image.style.opacity = '0';
                image.style.display = 'none';
            }
        });

        const currentDescription = descriptionsContainer.querySelector(`[data-index="${currentImageIndex}"]`);
        if (currentDescription) {
            currentDescription.style.display = 'grid';
        }

        updateDots(); // Update the dots to reflect the current image
    }

    function updateDescription() {
        const allDescriptions = descriptionsContainer.querySelectorAll('.image-description');
        allDescriptions.forEach((desc, index) => {
            desc.style.display = index === currentImageIndex ? 'grid' : 'none';
        });
    }

    function showPreviousImageWithFade() {
        currentImageIndex = (currentImageIndex - 1 + images.length) % images.length;
        showCurrentImageWithFade();
        updateDescription();
    }

    function showNextImageWithFade() {
        currentImageIndex = (currentImageIndex + 1) % images.length;
        showCurrentImageWithFade();
        updateDescription();
    }

    function startAutoCycling() {
        autoCycleTimer = setInterval(showNextImageWithFade, autoCycleInterval);
    }

    function stopAutoCycling() {
        clearInterval(autoCycleTimer);
    }

    function updateDots() {
        const dotElements = dotContainer.querySelectorAll('.dot');
        dotElements.forEach((dot, index) => {
            dot.classList.toggle('active', index === currentImageIndex);
        });
    }

    const navigation = document.createElement('div');
    navigation.className = 'carousel-navigation';

    const prevButton = document.createElement('button');
    prevButton.setAttribute('title','previous item');
    prevButton.innerHTML = '<i class="icon-keyboard_arrow_left"></i>';
    prevButton.className = 'prev-button';

    const nextButton = document.createElement('button');
    nextButton.setAttribute('title','next item');
    nextButton.innerHTML = '<i class="icon-keyboard_arrow_right"></i>';
    nextButton.className = 'next-button';

    let autoCycleTimer;

    prevButton.addEventListener('click', () => {
        stopAutoCycling();
        showPreviousImageWithFade();
        startAutoCycling();
    });

    nextButton.addEventListener('click', () => {
        stopAutoCycling();
        showNextImageWithFade();
        startAutoCycling();
    });

    startAutoCycling();

    navigation.append(prevButton, nextButton);
    carouselContainer.appendChild(navigation);

    function addImageToCarousel(src, description) {
        if (contentType === 'image') {
            const imageElement = document.createElement('img');
            const srcset = `${src} 480w, ${src} 920w`; // Adjust the srcset based on your requirements
        
            imageElement.src = src;
            imageElement.className = 'img-cover';
            imageElement.id = 'js-mainPhoto';
            imageElement.srcset = srcset;
            imageElement.sizes = '(min-width: 64em) 50vw, 100vw';
            imageElement.alt = description;
            imageElement.style.display = 'none';
        
            carouselImagesContainer.appendChild(imageElement);
            images.push(imageElement);
        
            const descriptionElement = document.createElement('div');
            descriptionElement.className = 'image-description';
            descriptionElement.innerText = description;
            descriptionElement.setAttribute('data-index', images.length - 1);
            descriptionElement.style.display = images.length === 1 ? 'block' : 'none';
            descriptionsContainer.appendChild(descriptionElement);
        
            if (images.length === 1) {
                carouselImagesContainer.querySelector('img').style.display = 'none';
            }
        }
        
        else if(contentType === 'quote'){
            carouselContainer.style = `background-color:${bg_color};box-shadow: 0 4px 12px rgb(0 0 0 / 0%);`;
            carouselImagesContainer.classList.add('quote-container');
            const imageElement = document.createElement('p');
            imageElement.innerText = src;
            imageElement.style.display="none";
            carouselImagesContainer.appendChild(imageElement);
            images.push(imageElement);
            const descriptionElement = document.createElement('div');
            descriptionElement.className = 'image-description';
            descriptionElement.innerText = description;
            descriptionElement.setAttribute('data-index', images.length - 1);
            descriptionElement.style.display = images.length === 1 ? 'block' : 'none';
            descriptionsContainer.appendChild(descriptionElement);
    
            if (images.length === 1) {
                carouselImagesContainer.querySelector('p').style.display = 'none';
            }
        }


        // Add a dot for the new image
        const dotElement = document.createElement('div');
        dotElement.classList.add('dot');
        dotElement.addEventListener('click', () => {
            stopAutoCycling();
            currentImageIndex = images.length - 1;
            showCurrentImageWithFade();
            startAutoCycling();
        });
        dotContainer.appendChild(dotElement);

        updateDots(); // Update the dots to reflect the new image
    }

    function addImagesFromJson(jsonData) {
        jsonData.forEach((item) => {
            const imageUrl = getImageUrl(item.versions);
            const description = item.caption;
            addImageToCarousel(imageUrl, description);
        });
    }
    function createLoaderElement(display=true) {
        if (display){
            const loader = document.createElement('section');
            loader.classList.add('loader');
            loader.style.display="flex";
            loader.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="111px" height="111px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
            <circle cx="30" cy="50" fill="#e90c2c" r="20">
              <animate attributeName="cx" repeatCount="indefinite" dur="1s" keyTimes="0;0.5;1" values="30;70;30" begin="-0.5s"/>
            </circle>
            <circle cx="70" cy="50" fill="#394719" r="20">
              <animate attributeName="cx" repeatCount="indefinite" dur="1s" keyTimes="0;0.5;1" values="30;70;30" begin="0s"/>
            </circle>
            <circle cx="30" cy="50" fill="#e90c2c" r="20">
              <animate attributeName="cx" repeatCount="indefinite" dur="1s" keyTimes="0;0.5;1" values="30;70;30" begin="-0.5s"/>
              <animate attributeName="fill-opacity" values="0;0;1;1" calcMode="discrete" keyTimes="0;0.499;0.5;1" dur="1s" repeatCount="indefinite"/>
            </circle>
            </svg>`;
            return document.body.appendChild(loader);
        }
        else{
            const a = document.querySelector('.loader')
            a.style.display='none'
        }

    }

    function addQuotesFromJson(jsonData) {
        jsonData.forEach((item) => {
            const imageUrl = item.text;
            const description = item.context;
            addImageToCarousel(imageUrl, description);
        });
    }

    if (!Array.isArray(imagesData) || imagesData.length === 0) {
        if(contentType === 'image') {
            addImageToCarousel('static/icons/image_placeholder.png', 'Default Image Description');
        }
        else if(contentType ==='quote') {
            addImageToCarousel('No quote available', 'Please upload quotes');
        }
    } else {
        if(contentType === 'image') {
            addImagesFromJson(imagesData);
        }else if(contentType ==='quote') {
            addQuotesFromJson(imagesData);
        }
    }

    carouselContainer.appendChild(carouselImagesContainer);
    carouselContainer.appendChild(navigation);

    return {
        container: carouselContainer,
        addImage: addImageToCarousel,
    };
}


export { createCarouselComponent };
