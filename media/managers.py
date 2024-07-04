
from django.db.models.query import QuerySet
from .version_photo import ImageProcessingService
from .similar_photo import SimilarPhotoDetector
from django.db import models
from django.db import transaction    
from django.db.models import Count, OuterRef, Subquery


class ImageManager(models.Manager):
    def __init__(self):
        # Initialize both services
        self.image_processing_service = ImageProcessingService()
        self.similar_photo_detector = SimilarPhotoDetector()

    def process_image_versions(self, image_instance):
        """
        Process an image to create different versions as specified in settings.
        """
        return self.image_processing_service.process_image(image_instance)

    def detect_duplicates(self, instance):
        """
        Detect duplicate images given uploaded_image.
        """
        similar_photos = self.similar_photo_detector.detect_duplicates(instance)
        self.save_clusters(similar_photos)
        


    def save_clusters(self, clusters):
        from .models import SimilarPhoto
        """
        Saves image clusters.
        """
        with transaction.atomic():
            # Retrieve all existing SimilarPhoto objects from the database
            existing_clusters = SimilarPhoto.objects.all()
            # Create a set to store images already assigned to clusters
            assigned_images = set()

            # Iterate through the clusters to save
            for cluster in clusters:
                # Check if the cluster has more than one image
                if len(cluster) > 1:
                    # Filter out images that have already been assigned to clusters
                    images_to_assign = [image for image in cluster if image not in assigned_images]

                    # Check if any of the images in the cluster are already in existing clusters
                    existing_cluster_with_images = [c for c in existing_clusters if c.images.filter(id__in=[image for image in images_to_assign]).exists()]
                    if existing_cluster_with_images:
                        # Merge the new cluster with the existing one
                        existing_cluster_with_images[0].images.add(*images_to_assign)
                        # Update the set of assigned images
                        assigned_images.update(images_to_assign)
                    else:
                        # Create a new cluster object
                        new_cluster = SimilarPhoto.objects.create()
                        # Assign images to the cluster
                        new_cluster.images.set(images_to_assign)
                        # Save the new cluster
                        new_cluster.save()
                        # Update the set of assigned images
                        assigned_images.update(images_to_assign)