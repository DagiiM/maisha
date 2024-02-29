from django.dispatch import receiver
from django.db.models.signals import post_save, pre_delete
from PIL import Image as PILImage 
from .models import Image
import os,uuid
from django.conf import settings
    
import cv2, numpy as np
from io import BytesIO
from django.core.files.uploadedfile import InMemoryUploadedFile


@receiver(post_save, sender=Image)
def create_image_versions(sender, instance: 'Image', created: bool, **kwargs) -> None:
    """
    Connect the generate_image_versions function to the post_save signal
    for the Image model.
    """
    if created and instance.file:
        # Define aspect ratio
        aspect_ratio = 3 / 3  # for a 3:4 aspect ratio

        # Define versions with adjusted heights based on the aspect ratio
        versions = {
            'thumbnail': {'width': 250, 'resize_mode': instance.resize_mode},
            'medium': {'width': 460, 'resize_mode': instance.resize_mode},
            'large': {'width': 800, 'resize_mode': instance.resize_mode},
            'social': {'width': 1080, 'resize_mode': instance.resize_mode},
        }
        for version_data in versions.values():
            version_data['height'] = calculate_height_with_aspect_ratio(version_data['width'], aspect_ratio)

        # Generate image versions
        generate_image_versions(instance, versions)


def calculate_height_with_aspect_ratio(width, aspect_ratio):
    """
    Calculate the height based on the given width and aspect ratio.

    Args:
        width (int): The width of the image.
        aspect_ratio (float): The aspect ratio (height/width).

    Returns:
        int: The calculated height.
    """
    return int(width * aspect_ratio)


def generate_image_versions(instance: 'Image', versions: dict) -> None:
    """
    Helper function to create image versions for a given Image instance and definitions.

    Args:
        instance: The Image instance for which to generate versions.
        versions: A dictionary containing version names as keys and
                  transformation definitions as values.
    """
    image_versions = {}  # Dictionary to store version URLs
    
    for version_name, version_data in versions.items():
        width = version_data.get('width')
        height = version_data.get('height')
        resize_mode = version_data.get('resize_mode', 'ANTIALIAS')
        quality = version_data.get('quality', 90)

        if not all([width, height, resize_mode]):
            raise ValueError(f"Invalid version definition for '{version_name}'.")

        try:
            with PILImage.open(instance.file.path) as image:
                # Resize the image
                atr = getattr(PILImage, resize_mode.upper(), None)
                if atr:
                    image = enhance_image(image)
                    image = image.resize((width, height), atr)
                else:
                    raise ValueError(f"Invalid resize mode '{resize_mode}' for '{version_name}'.")

                # Generate a random UUID string for the filename
                random_filename = str(uuid.uuid4())
                
                # Get the directory path of the original image file
                file_path, file_name = os.path.split(instance.file.path)

                # Construct the thumbnails directory path
                thumbnails_dir = os.path.join(file_path, 'versions')

                # Create the thumbnails directory if it doesn't exist
                os.makedirs(thumbnails_dir, exist_ok=True)

                # Construct the subfolder path for the resized image version
                subfolder_name = version_name
                subfolder_path = os.path.join(thumbnails_dir, subfolder_name)

                # Create the subfolder for the current size if it doesn't exist
                os.makedirs(subfolder_path, exist_ok=True)

                # Construct the file path for the resized image version within the subfolder
                version_filename =  f"{random_filename}.png"
                version_path = os.path.join(subfolder_path, version_filename)

                # Save the resized image version
                image.save(version_path, 'PNG', quality=quality)

                # Get the relative path of the version file
                relative_version_path = os.path.relpath(version_path, settings.MEDIA_ROOT)

                # Store the version URL in the dictionary
                image_versions[version_name] = os.path.join(settings.MEDIA_URL, relative_version_path)
                
                
        except Exception as e:
            # Log the error instead of printing
            print(f"Error generating version '{version_name}': {e}")

    # Update the version_urls field of the instance
    instance.versions = image_versions
    instance.save()


def enhance_image(img):
    # Convert the Pillow image to an OpenCV image
    open_cv_image = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)

    # Perform image enhancement using OpenCV (example: increase contrast)
    enhanced_image = cv2.convertScaleAbs(open_cv_image, alpha=1.2, beta=0)

    # Convert the enhanced OpenCV image back to a Pillow image
    enhanced_image = PILImage.fromarray(cv2.cvtColor(enhanced_image, cv2.COLOR_BGR2RGB))

    return enhanced_image

    
def ready(self):
    post_save.connect(create_image_versions, sender=Image)
    
    
@receiver(pre_delete, sender=Image)
def image_pre_delete(sender, instance, **kwargs):
    print(f"Image {instance.id} deleted.")