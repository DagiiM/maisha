const getImageUrl = (versions)=> {
    // Get viewport width
    var viewportWidth = document.documentElement.clientWidth;
    
    // Determine which image version to use based on viewport width
    if (viewportWidth >= 920 && versions.large) {
        return versions.large;
    } else if (viewportWidth >= 480 && versions.medium) {
        return versions.medium;
    } else if (viewportWidth <= 480 && versions.thumbnail) {
        return versions.thumbnail;
    }
     else {
        return versions.file; // Use the original image if none of the conditions are met
    }
    
}

export default getImageUrl;