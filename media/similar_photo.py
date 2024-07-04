
import cv2
import numpy as np
import tempfile
from PIL import Image as PILImage, UnidentifiedImageError
import os

from app.foundation.processor import Processor
from app.foundation.pipeline import Pipeline
from . import config

class ClusterRepresentativeExtractor(Processor):
    def __init__(self):
        super().__init__()
        self.clusters = None  # Initialize clusters to None

    def initialize(self):
        from .models import SimilarPhoto, Image
        # Fetch clusters when the extractor is initialized
        self.clusters = [list(cluster.images.all()) for cluster in SimilarPhoto.objects.all()]
        self.all_images = Image.objects.all()

    def process_batch(self, instances):
        if self.clusters is None:
            self.initialize()

        cluster_representatives = []

        for instance in instances:
            for cluster in self.clusters:
                if cluster:
                    representative_image = cluster[0]  # Get the first image in the cluster
                    if representative_image:
                        representative_image.similarity_explored = True
                        cluster_representatives.append(representative_image)

            all_images = self.all_images.exclude(id__in=[image.id for image in cluster_representatives]).filter(similarity_explored=False)
            cluster_representatives.extend(all_images)

            # Mark the uploaded instance as explored
            instance.similarity_explored = True

            # Add the uploaded instance as a potential representative
            cluster_representatives.append(instance)
        return cluster_representatives



class FeatureExtractor(Processor):
    def __init__(self, resize_mode='BICUBIC', resize_size=(100, 100)):
        super().__init__()
        self.resize_mode = resize_mode
        self.resize_size = resize_size
        self.sift = cv2.SIFT_create()

    def process_batch(self, queryset):
        if hasattr(queryset, '__iter__') and not isinstance(queryset, str):
            for image in queryset:
                yield from self._process_single_image(image)
        else:
            yield from self._process_single_image(queryset)

    def _process_single_image(self, image):
        try:
            image_file = image.file
            image_path = image_file.path
            if os.path.isfile(image_path):
                with PILImage.open(image_path) as pil_image:
                    image_resized = pil_image.resize(self.resize_size, getattr(PILImage, self.resize_mode.upper(), None))
                    image_resized = image_resized.convert('RGB')
                    with tempfile.NamedTemporaryFile(suffix='.jpg', delete=False) as temp_file:
                        image_resized.save(temp_file.name)
                        img = cv2.imread(temp_file.name)
                        if img is not None:
                            gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
                            keypoints, descriptors = self.sift.detectAndCompute(gray, None)
                            yield (image, keypoints, descriptors)  # Yield image instance along with features
                os.unlink(temp_file.name)
            else:
                print(f"Skipping {image_path}: File does not exist")
        except AttributeError:
            print(f"Skipping {image}: No 'file' attribute or 'file' is None")
        except UnidentifiedImageError:
            print(f"Skipping {image_path}: Unable to identify image format")



class SimilarityComputer(Processor):
    def __init__(self):
        super().__init__()
        
    def process_batch(self, features):
        similarity_scores = []
        valid_features = [feature for feature in features if feature is not None]
        for i, (image1, keypoints1, descriptors1) in enumerate(valid_features):
            for j in range(i + 1, len(valid_features)):
                image2, keypoints2, descriptors2 = valid_features[j]
                score = self.compute_similarity(descriptors1, descriptors2)
                similarity_scores.append((image1.id, image2.id, score))
        return similarity_scores

    def compute_similarity(self, descriptors1, descriptors2):
        """Computes similarity score between image descriptors."""
        if descriptors1 is None or descriptors2 is None:
            return 0.0
        if descriptors1.shape[0] == 0 or descriptors2.shape[0] == 0:
            return 0.0
        distances = np.linalg.norm(descriptors1[:, np.newaxis] - descriptors2, axis=-1)
        min_distance = np.min(distances)
        return 1 / (1 + min_distance)

class Clusterer(Processor):
    def __init__(self, threshold=0.5):
        super().__init__()
        self.threshold = threshold

    def process_batch(self, similarity_scores):
        clusters = []
        for image1, image2, score in similarity_scores:
            if score >= self.threshold:
                found = False
                for cluster in clusters:
                    if image1 in cluster or image2 in cluster:
                        cluster.update({image1, image2})
                        found = True
                        break
                if not found:
                    clusters.append({image1, image2})
        return [list(cluster) for cluster in clusters]
    


class SimilarPhotoDetector:
    def __init__(self):
        self.pipeline = Pipeline()
        self.pipeline.add_processor(ClusterRepresentativeExtractor())
        self.pipeline.add_processor(FeatureExtractor())
        self.pipeline.add_processor(SimilarityComputer())
        self.pipeline.add_processor(Clusterer())

    def detect_duplicates(self, instance):
        clusters = self.pipeline.run(instance)
        return clusters
