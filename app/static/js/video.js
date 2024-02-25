document.addEventListener('DOMContentLoaded', function () {

    // play video
    lazyLoadVideo()

    
  });
  

  function lazyLoadVideo(){
    // Get the video element
    var video = document.getElementById("eleso-video");
    let play_button = document.querySelector('.eleso-video-container');
  
      
    if(play_button){
      play_button.addEventListener('click', () => {
        let overlay = document.querySelector('.poster-wrapper');
        if (video.paused) {
            video.play();
            // Hide the overlay
            overlay.style.display = 'none';

          } else {
            video.pause();
            overlay.style.display = 'flex'; // Show the overlay again if paused
          }
          

      });
  
    }
  
  }