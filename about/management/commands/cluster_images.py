from django.core.management.base import BaseCommand
from media.models import Image

class Command(BaseCommand):
    help = 'Cluster all images associated with DuplicateImage instances'

    def handle(self, *args, **options):
        images = Image.objects.all()
        image_paths = []
        for dimage in images:
            image_paths.append(dimage.file.path)
        dimage.cluster_images(image_paths)
        self.stdout.write(self.style.SUCCESS('Image clustering process completed.'))