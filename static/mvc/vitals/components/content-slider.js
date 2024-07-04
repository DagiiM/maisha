import { Component } from './component.js';

class ContentSlider extends Component {
  constructor(container, data, options = {}) {
    super();

    // Ensure container is a DOM element
    if (!(container instanceof HTMLElement)) {
      throw new Error(`Container must be a DOM element`);
    }

    // Initialize properties
    this.container = container;
    this.container.classList.add('eleso-slider');
    this.data = data;
    this.options = {
      autoSlide: options.autoSlide !== undefined ? options.autoSlide : false,
      autoSlideDelay: options.autoSlideDelay || 9000,
      transitionDuration: options.transitionDuration || 500,
      loop: options.loop !== undefined ? options.loop : false,
      navigation: options.navigation !== undefined ? options.navigation : false,
      pagination: options.pagination || true,
      touchSwipe: options.touchSwipe !== undefined ? options.touchSwipe : true,
      responsive: options.responsive || false,
    };
    this.slideIndex = options.initialSlide || 0;
    this.slideInterval = null;
    this.isDragging = false;
    this.dragStartX = null;
    this.dragStartY = null;
    this.currentTranslate = 0;
    this.slideWidth = 0;
    this.slides = [];
    this.paginationDots = [];
    
    this.init();
  }

  init() {
    // Ensure slider exists within the container
    this.slider = this.container.querySelector('.eleso-content-slider');
    if (!this.slider) {
      throw new Error("Slider element not found within container");
    }

    // Ensure there are slides in the slider
    this.slides = Array.from(this.slider.querySelectorAll('.eleso-slide'));
    if (this.slides.length === 0) {
      throw new Error("No slides found in the slider");
    }

    // Get the width of the slides
    this.slideWidth = this.slides[0].offsetWidth;

    // Create pagination if needed
    if (this.options.pagination) {
      this.createPagination();
    }

    // Create navigation if needed
    if (this.options.navigation) {
      this.createNavigation();
    }

    // Add event listeners
    this.addEventListeners();

    // Start slideshow if autoSlide is enabled
    if (this.options.autoSlide) {
      this.startSlideshow();
    }

    // Show the initial slide
    this.showSlide(this.slideIndex);
  }

  createPagination() {
    const paginationContainer = this.createElement('div', 'eleso-slider-pagination');
    this.slider.parentNode.insertBefore(paginationContainer, this.slider.nextSibling);

    this.slides.forEach((_, index) => {
      const paginationDot = this.createElement('span', 'eleso-pagination-dot');
      paginationDot.addEventListener('click', () => this.showSlide(index));
      paginationContainer.appendChild(paginationDot);
    });

    this.paginationDots = Array.from(paginationContainer.children);
    this.updatePagination();
  }

  createNavigation() {
    const prevButton = this.createElement('button', 'eleso-slider-prev', {}, 'Prev');
    prevButton.addEventListener('click', () => this.plusSlides(-1));
    const nextButton = this.createElement('button', 'eleso-slider-next', {}, 'Next');
    nextButton.addEventListener('click', () => this.plusSlides(1));

    this.container.appendChild(prevButton);
    this.container.appendChild(nextButton);
  }

  addEventListeners() {
    this.slider.addEventListener('mousedown', this.handleDragStart);
    this.slider.addEventListener('mouseup', this.handleDragEnd);
    this.slider.addEventListener('mouseleave', this.handleDragEnd);
    this.slider.addEventListener('mousemove', this.handleDrag);

    this.slider.addEventListener('touchstart', this.handleTouchStart, { passive: true });
    this.slider.addEventListener('touchmove', this.handleTouchMove, { passive: false });
    this.slider.addEventListener('touchend', this.handleTouchEnd);
    this.slider.addEventListener('touchcancel', this.handleTouchEnd);

    window.addEventListener('resize', this.handleResize);
  }

  handleTouchStart = (e) => {
    if (e.touches.length > 1) return; // Ignore multi-touch gestures
    this.isDragging = true;
    this.dragStartX = e.touches[0].clientX;
    this.dragStartY = e.touches[0].clientY; // Added Y position
    this.currentTranslate = this.slideIndex * -this.slideWidth;
  };

  handleTouchMove = (e) => {
    if (!this.isDragging) return;

    const currentX = e.touches[0].clientX;
    const currentY = e.touches[0].clientY; // Added Y position
    const diffX = currentX - this.dragStartX;
    const diffY = currentY - this.dragStartY; // Added Y difference

    // Check if vertical scrolling
    if (Math.abs(diffY) > Math.abs(diffX)) {
      this.isDragging = false;
      return;
    }

    e.preventDefault(); // Prevent scrolling
    this.currentTranslate += diffX;
    this.updateSlidePositions();
  };

  handleTouchEnd = () => {
    if (!this.isDragging) return;
    this.isDragging = false;
    const movedBy = this.currentTranslate / this.slideWidth;

    if (Math.abs(movedBy) > 0.5) {
      this.plusSlides(movedBy > 0 ? -1 : 1);
    } else {
      this.showSlide(this.slideIndex);
    }

    this.resetSlideshow();
  };

  handleDragStart = (e) => {
    this.isDragging = true;
    this.dragStartX = e.type === 'touchstart' ? e.touches[0].clientX : e.clientX;
    e.preventDefault();
  };

  handleDrag = (e) => {
    if (!this.isDragging) return;
    const currentX = e.type === "touchmove" ? e.touches[0].clientX : e.clientX;
    const diffX = currentX - this.dragStartX;
    this.currentTranslate = this.slideIndex * -this.slideWidth + diffX;
    this.updateSlidePositions();
  };

  handleDragEnd = () => {
    if (!this.isDragging) return;
    this.isDragging = false;
    const movedBy = this.currentTranslate / this.slideWidth;

    if (Math.abs(movedBy) > 0.5) {
      this.plusSlides(movedBy > 0 ? -1 : 1);
    } else {
      this.showSlide(this.slideIndex);
    }

    this.resetSlideshow();
  };

  handleResize = () => {
    this.slideWidth = this.slides[0].offsetWidth;
    this.showSlide(this.slideIndex);
  };

  updateSlidePositions() {
    this.slides.forEach((slide, index) => {
      slide.style.transform = `translateX(${this.currentTranslate + index * this.slideWidth}px)`;
    });
  }

  startSlideshow() {
    this.slideInterval = setInterval(() => {
      this.plusSlides(1);
    }, this.options.autoSlideDelay);
  }

  resetSlideshow() {
    clearInterval(this.slideInterval);
    if (this.options.autoSlide) {
      this.startSlideshow();
    }
  }

  plusSlides(n) {
    let newIndex = (this.slideIndex + n) % this.slides.length;
    if (newIndex < 0) {
      newIndex = this.slides.length + newIndex;
    }
    this.showSlide(newIndex);
  }

  showSlide(index) {
    this.slideIndex = index;
    this.currentTranslate = -this.slideIndex * this.slideWidth;
    this.updateSlidePositions();
    this.slider.style.transition = `transform ${this.options.transitionDuration}ms ease-in-out`;
    this.slides.forEach((slide, i) => {
      slide.style.transform = `translateX(${this.currentTranslate}px)`;
    });
    this.updatePagination();
    this.resetSlideshow();
  }

  updatePagination() {
    if (!this.options.pagination) return;
    this.paginationDots.forEach((dot, index) => {
      dot.classList.toggle('active', index === this.slideIndex);
    });
  }
}

export { ContentSlider };
