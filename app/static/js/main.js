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