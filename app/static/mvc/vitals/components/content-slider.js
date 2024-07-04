

class ContentSlider {
    constructor(slider, data, options = {}) {
      this.slider = slider.querySelector('.eleso-content-slider');
      this.data = data;
      this.custom_offset = options.customOffset || 0;
      this.slides = Array.from(this.slider.getElementsByClassName("eleso-slide"));
      this.slideIndex = options.initialSlide || 0;
      this.slideInterval = null;
      this.isDragging = false;
      this.startDragX = null;
      this.currentTranslate = 0;
      this.slideWidth = 0;
      this.paginationDots = []; // Initialize as an empty array
      this.options = {
        autoSlide: options.autoSlide || false,
        autoSlideDelay: options.autoSlideDelay || 3000,
        transitionDuration: options.transitionDuration || 500,
        loop: options.loop || false,
        navigation: options.navigation || true,
        pagination: options.pagination || false,
        touchSwipe: options.touchSwipe || true,
        responsive: options.responsive || false,
        ...options,
      };
  
      if (this.options.pagination) {
        this.createPagination();
      }
  
      this.initSlider();
      this.addEventListeners();
      if (this.options.autoSlide) {
        this.startSlideshow();
      }
      if (this.options.responsive) {
        this.makeResponsive();
      }
    }

    initSlider() {
      this.slider.setAttribute("role", "region");
      this.slides.forEach((slide) => {
        slide.setAttribute("role", "group");
        slide.setAttribute("aria-live", "polite");
      });
      
      this.updateSlideWidth();
      // Set initial position between 5% and 95% of slider width
      this.currentTranslate = -this.slideWidth * (this.options.initialSlide + 0.5);
      this.applySlideTransition();
      this.showSlides(this.slideIndex);

      this.showSlides(this.slideIndex);
      if (this.options.pagination) {
        let pagination = document.querySelector('.eleso-slider-pagination');
        if( !pagination){
          this.createPagination();
        }
      }
    }

    updateSlideWidth() {
      const slideRect = this.slides[0].getBoundingClientRect();
      const slideMargin = (slideRect.width - this.slides[0].offsetWidth) / 2; // Total margin on both sides
      this.slideWidth = slideRect.width + slideMargin + this.custom_offset;
    }
    
    

    showSlides(n) {
      const sliderWidth = this.slider.offsetWidth;
      const maxVisibleSlides = Math.floor(sliderWidth / this.slideWidth);
      this.slideIndex = ((n % this.slides.length) + this.slides.length) % this.slides.length; // Handle loop

      const newTranslate = -(this.slideIndex * this.slideWidth);
      this.currentTranslate = newTranslate;

      this.applySlideTransition();
      if (this.options.pagination) {
        this.updatePagination();
      }
    }


    applySlideTransition() {
      this.slides.forEach((slide, index) => {
        slide.style.transition = `transform ${this.options.transitionDuration}ms ease-in-out`;
        const positionX = this.currentTranslate //+ (index * this.slideWidth);
        slide.style.transform = `translateX(${positionX}px)`;
      });
    }
    

    

    plusSlides(n) {
      this.showSlides(this.slideIndex + n);
    }

    startSlideshow() {
      this.slideInterval = setInterval(() => {
        if (this.slideIndex === this.slides.length - 1) {
          // If last slide is reached, reset to first slide
          this.slideIndex = 0;
          this.currentTranslate = 0;
        } else {
          this.plusSlides(1);
        }
      }, this.options.autoSlideDelay);
    }


    resetSlideshow() {
      clearInterval(this.slideInterval);
      if (this.options.autoSlide) {
        this.startSlideshow();
      }
    }

    handleDragStart = (e) => {
      this.isDragging = true;
      this.dragStartX = e.type === "touchstart" ? e.touches[0].clientX : e.clientX;
      this.slides.forEach((slide) => {
        slide.style.transition = "none";
      });
    };

    handleDragEnd = () => {
      if (!this.isDragging) return;
      this.isDragging = false;
      const movedBy = this.dragEndX - this.dragStartX;
      if (Math.abs(movedBy) > this.slideWidth / 4) { // threshold to decide if slide should change
        this.plusSlides(movedBy > 0 ? -1 : 1);
      } else {
        this.plusSlides(0); // Stay on the current slide
      }
      this.resetSlideshow();
    };

    handleDrag = (e) => {
      if (!this.isDragging) return;
      e.preventDefault();
      const currentX = e.type === "touchmove" ? e.touches[0].clientX : e.clientX;
      const diffX = currentX - this.dragStartX;
      this.dragEndX = currentX;
      const translateX = this.currentTranslate + diffX;
      this.slides.forEach((slide, index) => {
        //slide.style.transform = `translateX(${translateX + (index * this.slideWidth)}px)`;
      });
    };

    handleKeydown = (e) => {
      if (e.key === "ArrowLeft") {
        this.plusSlides(-1);
      } else if (e.key === "ArrowRight") {
        this.plusSlides(1);
      }
    };


    addEventListeners() {
      // Simplified for brevity. Add touch and keydown events similarly.
      this.slider.addEventListener("mousedown", this.handleDragStart);
      this.slider.addEventListener("mouseup", this.handleDragEnd);
      this.slider.addEventListener("mousemove", this.handleDrag);
      this.slider.addEventListener("mouseleave", this.handleDragEnd);
      this.slider.addEventListener("touchstart", this.handleDragStart);
      this.slider.addEventListener("touchend", this.handleDragEnd);
      this.slider.addEventListener("touchmove", this.handleDrag);
      this.slider.addEventListener("keydown", this.handleKeydown);
      window.addEventListener("resize", () => {
        this.updateSlideWidth();
        this.showSlides(this.slideIndex);
      });
    }

    updatePagination() {
      if (!this.options.pagination || this.paginationDots.length === 0) {
        return;
      }
  
      this.paginationDots.forEach((dot, index) => {
        if (index === this.slideIndex) {
          dot.classList.add("active");
        } else {
          dot.classList.remove("active");
        }
      });
    }
  
    createPagination() {
      const paginationContainer = document.createElement("div");
      paginationContainer.className = "eleso-slider-pagination";
      this.slider.parentNode.insertBefore(paginationContainer, this.slider.nextSibling);
  
      this.slides.forEach((_, index) => {
        const paginationDot = document.createElement("span");
        paginationDot.className = "eleso-pagination-dot";
        paginationDot.addEventListener("click", () => this.showSlides(index));
        paginationContainer.appendChild(paginationDot);
      });
  
      this.paginationDots = Array.from(paginationContainer.children);
      this.updatePagination();
    }


  makeResponsive() {
    const sliderWidth = this.slider.offsetWidth;
    const maxVisibleSlides = Math.floor(sliderWidth / this.slideWidth);
    this.slideWidth = sliderWidth / maxVisibleSlides; // Adjust slide width based on visible slides
    this.slides.forEach(slide => {
      slide.style.width = `${this.slideWidth}px`; // Apply adjusted width to each slide
    });
    this.showSlides(this.slideIndex);
  }

  

  }

  export { ContentSlider };