import os
import shutil
import uuid
import cv2
import numpy as np
from PIL import Image as PILImage
from django.db import models
from django.conf import settings
from . import config
import tempfile
from abc import ABC, abstractmethod
from app.foundation.processor import Processor
from app.foundation.pipeline import Pipeline
from datetime import datetime

class Enhancer(ABC):
    @abstractmethod
    def enhance(self, image):
        """Enhance the given image."""
        pass

class Resizer(ABC):
    @abstractmethod
    def resize(self, image, width, height, resize_mode):
        """Resize the given image."""
        pass
    

class OpenCVImageEnhancer(Enhancer):
    def enhance(self, image):
        open_cv_image = cv2.cvtColor(np.array(image), cv2.COLOR_RGB2BGR)
        enhanced_image = cv2.convertScaleAbs(open_cv_image, alpha=1.2, beta=0)
        enhanced_image = PILImage.fromarray(cv2.cvtColor(enhanced_image, cv2.COLOR_BGR2RGB))
        return enhanced_image


class PILImageResizer(Resizer):
    def resize(self, image, width, height, resize_mode):
        return image.resize((width, height), getattr(PILImage, resize_mode.upper(), None))


class ImageVersionProcessor(Processor):
    def __init__(self, batch_size=None, image_enhancer=None, image_resizer=None):
        super().__init__(batch_size=batch_size)
        self.image_enhancer = image_enhancer or OpenCVImageEnhancer()
        self.image_resizer = image_resizer or PILImageResizer()

    def process_batch(self, instances):
        if isinstance(instances, (list, tuple)):
            return self.process_batch_images(instances)
        else:
            return self.process_single_image(instances)

    def process_batch_images(self, instances):
        for instance in instances:
            self.process_single_image(instance)

    def process_single_image(self, image_instance):
        image_versions = {}
        for version_name, version_data in config.IMAGE_VERSIONS.items():
            width = version_data['width']
            height = self.calculate_height_with_aspect_ratio(width)
            resize_mode = version_data['resize_mode']
            quality = version_data.get('quality', 95)
            try:
                with PILImage.open(image_instance.file.path) as image:
                    image = self.image_enhancer.enhance(image)
                    image = self.image_resizer.resize(image, width, height, resize_mode)
                    #random_filename = str(uuid.uuid4())
                    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
                    image_id = str(image_instance.id)
                    random_filename = f"{timestamp}{image_id}"
                    file_path, file_name = os.path.split(image_instance.file.path)
                    thumbnails_dir = os.path.join(file_path, 'versions')
                    subfolder_name = version_name
                    subfolder_path = os.path.join(thumbnails_dir, subfolder_name)
                    os.makedirs(thumbnails_dir, exist_ok=True)
                    os.makedirs(subfolder_path, exist_ok=True)
                    version_filename = f"{random_filename}.png"
                    version_path = os.path.join(subfolder_path, version_filename)
                    image.save(version_path, 'PNG', quality=quality)
                    relative_version_path = os.path.relpath(version_path, settings.MEDIA_ROOT)
                    image_versions[version_name] = os.path.join(settings.MEDIA_URL, relative_version_path)
            except Exception as e:
                print(f"Error generating version '{version_name}': {e}")

        image_instance.versions = image_versions
        image_instance.save()

    def calculate_height_with_aspect_ratio(self, width):
        """Calculate the height based on the given width and aspect ratio."""
        return int(width * config.IMAGE_ASPECT_RATIO)
    
class ImageProcessingService:
    def __init__(self):
        self.pipeline = Pipeline()
        self.pipeline.add_processor(ImageVersionProcessor())

    def process_image(self, instances):
        return self.pipeline.run(instances)