class Lightbox {
    constructor() {
      this.lightboxes = [];
      this.currentLightbox = null;
      this.initLightboxes();
    }
  
    initLightboxes() {
      const lightboxTriggers = document.querySelectorAll('.lightbox-trigger');
      lightboxTriggers.forEach((trigger) => {
        trigger.addEventListener('click', this.openLightbox.bind(this));
      });
    }
  
    openLightbox(event) {
      event.preventDefault();
      const targetLink = event.currentTarget;
      const lightboxId = targetLink.getAttribute('data-lightbox-id');
      const imageUrl = targetLink.href;
  
      let lightbox = this.lightboxes.find((lb) => lb.id === lightboxId);
      if (!lightbox) {
        lightbox = this.createLightbox(lightboxId, imageUrl);
        this.lightboxes.push(lightbox);
      }
  
      lightbox.show();
      this.currentLightbox = lightbox;
    }
  
    createLightbox(id, imageUrl) {
      const lightbox = document.createElement('div');
      lightbox.id = id;
      lightbox.classList.add('eleso-lightbox');
  
      const lightboxImage = document.createElement('img');
      lightboxImage.src = imageUrl;
  
      const closeButton = document.createElement('span');
      closeButton.classList.add('eleso-close-button');
      closeButton.innerHTML = '&times;';
      closeButton.addEventListener('click', () => this.closeLightbox(lightbox));
  
      lightbox.appendChild(lightboxImage);
      lightbox.appendChild(closeButton);
  
      return lightbox;
    }
  
    closeLightbox(lightbox) {
      document.body.removeChild(lightbox);
      this.currentLightbox = null;
    }
  
    show() {
      if (this.currentLightbox) {
        document.body.appendChild(this.currentLightbox);
      }
    }
  }
  
export { Lightbox };