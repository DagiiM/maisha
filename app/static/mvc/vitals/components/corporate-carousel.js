import getImageUrl from '../../vitals/utils/image_version.js';

    class corporateCarousel {
                constructor(data) {
                    this.element = this.generateCarouselContent(data);
                    this.slides = this.element.querySelectorAll('.eleso-corporate-carousel-slide');
                    this.controls = this.element.querySelectorAll('.eleso-corporate-carousel-controls button');
                    this.currentSlide = 0;
                    this.initCarousel();
                }
        
                initCarousel() {
                    this.showSlide(0);
                    this.controls.forEach((control, index) => {
                        control.addEventListener('click', () => this.showSlide(index));
                    });
                    setInterval(() => this.showSlide(this.currentSlide + 1), 5000);
                }
        
                showSlide(n) {
                    this.slides[this.currentSlide].classList.remove('active');
                    this.controls[this.currentSlide].classList.remove('active');
                    this.currentSlide = (n + this.slides.length) % this.slides.length;
                    this.slides[this.currentSlide].classList.add('active');
                    this.controls[this.currentSlide].classList.add('active');
                }

                // Function to dynamically generate carousel content
            generateCarouselContent(data) {
                const carousel = document.querySelector('.eleso-corporate-carousel');
                const controlsContainer = document.createElement('div');
                controlsContainer.className = 'eleso-corporate-carousel-controls';
                carousel.innerHTML = ''; // Clear existing carousel content
        
                data.results.forEach((result, index) => {
                    // Create slide
                    const slide = document.createElement('div');
                    slide.className = 'eleso-corporate-carousel-slide';
                    if (index === 0) slide.classList.add('active'); // Make the first slide active by default
        
                    // Create image for slide
                    const img = document.createElement('img');
                    img.src = `${getImageUrl(result.versions)}`; // Using large version for demonstration
                    img.alt = result.caption;
                    slide.appendChild(img);
        
                    // Create slide content
                    const content = document.createElement('div');
                    content.className = 'eleso-corporate-carousel-content';
                    content.innerHTML = `
                        <h1 class="eleso-corporate-carousel-title">${''}</h1>
                        <p class="eleso-corporate-carousel-subtitle">${result.caption || ''}</p>
                        <a href="#" class="eleso-corporate-carousel-button">Learn More</a>
                    `;
                    slide.appendChild(content);
        
                    // Add slide to carousel
                    carousel.appendChild(slide);
        
                    // Create control button for slide
                    const controlButton = document.createElement('button');
                    if (index === 0) controlButton.classList.add('active');
                    controlsContainer.appendChild(controlButton);
                });
        
                // Add controls to carousel
                carousel.appendChild(controlsContainer);
        
                return carousel;
            }
          }

export { corporateCarousel };