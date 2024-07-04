document.addEventListener('DOMContentLoaded', () => {
  
  let menuIcon = document.querySelector('header .nav-right i.icon-menu');
  let cancelIcon = document.querySelector('header .nav-right i.icon-cancel');
  let mobileElement = document.querySelector('mobile');

  let iconShare = document.querySelector(".share-card i.icon-share");
  let shareCardBody = document.querySelector(".share-card .share-card-body");

  const textElement = document.querySelector('.eleso-typing-effect #text');
  const cursorElement = document.querySelector('.eleso-typing-effect #text #cursor');
  

  
  if (menuIcon){
    menuIcon.addEventListener('click', () => {
      mobileElement.classList.add('eleso-mobile-nav-active');
      cancelIcon.classList.add('active');
      menuIcon.classList.remove('active');
    });
  }

  if (cancelIcon){
    cancelIcon.addEventListener('click', () => {
      mobileElement.classList.remove('eleso-mobile-nav-active');
      cancelIcon.classList.remove('active');
      menuIcon.classList.add('active');
    });
  }
  
  if (iconShare){
    iconShare.addEventListener('click', () => {
      shareCardBody.classList.toggle('active');
    });
  }

  
  if(textElement){
    const typingEffect = new TypingEffect(textElement, cursorElement);
    typingEffect.startTyping();
  }

let contentCard =document.querySelectorAll('eleso-content-card')
if (contentCard){
  contentCard.forEach(card => {
    const body = card.querySelector('.eleso-content-card__body');
    const showMoreBtn = card.querySelector('.eleso-content-card__show-more');
    const showLessBtn = card.querySelector('.eleso-content-card__show-less');
  
    showMoreBtn.addEventListener('click', () => {
      body.classList.remove('eleso-content-card__body--truncated');
      showMoreBtn.style.display = 'none';
      showLessBtn.style.display = 'inline';
    });
  
    showLessBtn.addEventListener('click', () => {
      body.classList.add('eleso-content-card__body--truncated');
      showMoreBtn.style.display = 'inline';
      showLessBtn.style.display = 'none';
    });
  
    if (body.scrollHeight > body.offsetHeight) {
      body.classList.add('eleso-content-card__body--truncated');
      showMoreBtn.style.display = 'inline';
    } else {
      showMoreBtn.style.display = 'none';
      showLessBtn.style.display = 'none';
    }
  });
}

const showMoreBtn = document.querySelector('.eleso-hero-section__button');
    const heroDescription = document.querySelector('.eleso-hero-section__description');

    function toggleShowMore() {
      heroDescription.classList.toggle('eleso-hero-section__description--show-more');
      showMoreBtn.textContent = heroDescription.classList.contains('eleso-hero-section__description--show-more') ? 'Show Less' : 'Show More';
    }

    function checkDescriptionHeight() {
      if (heroDescription.scrollHeight > heroDescription.offsetHeight) {
        showMoreBtn.classList.add('eleso-hero-section__button--visible');
      } else {
        showMoreBtn.classList.remove('eleso-hero-section__button--visible');
      }
    }

    if(showMoreBtn){
      showMoreBtn.addEventListener('click', toggleShowMore);
      window.addEventListener('load', checkDescriptionHeight);
      window.addEventListener('resize', checkDescriptionHeight);
    }


    const seeMoreBtns = document.querySelectorAll('.eleso-see-more-btn');
    
    if(seeMoreBtns){
      seeMoreBtns.forEach(btn => {
        btn.addEventListener('click', () => {
          const contentSection = btn.closest('.eleso-aligned-image-block__text');
          const hiddenTexts = contentSection.querySelectorAll('.eleso-content-text.eleso-hide');
          const visibleTexts = contentSection.querySelectorAll('.eleso-content-text:not(.eleso-hide)');

          if (btn.textContent === 'See More') {
            hiddenTexts.forEach(text => {
              text.classList.remove('eleso-hide');
            });
            btn.textContent = 'See Less';
          } else {
            visibleTexts.forEach(text => {
              text.classList.add('eleso-hide');
            });
            btn.textContent = 'See More';
          }
        });
      });
    }



});







function TypingEffect(textElement, cursorElement, typingSpeed = 100, delayAfterTyping = 5000) {
  this.textElement = textElement;
  this.cursorElement = cursorElement;
  this.originalText = this.textElement.textContent.trim();
  this.typingSpeed = typingSpeed;
  this.delayAfterTyping = delayAfterTyping;

  this.startTyping = function () {
    this.textElement.textContent = ''; // Clear existing content
    this.typeCharacter();
  };

  this.typeCharacter = function () {
    let index = 0;

    const typeCharacterRecursive = () => {
      this.textElement.textContent += this.originalText[index];
      index++;

      if (index < this.originalText.length) {
        setTimeout(typeCharacterRecursive, this.typingSpeed);
      } else {
        setTimeout(this.startTyping.bind(this), this.delayAfterTyping);
      }
    };

    typeCharacterRecursive(); // Start the typing function
  };
}