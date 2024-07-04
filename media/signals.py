from django.dispatch import receiver
from django.db.models.signals import post_save, pre_delete,post_delete
from .models import Image,Media
from .managers import ImageManager
from trash.models import Trash
from django_q.tasks import async_task
from django.contrib.contenttypes.models import ContentType

@receiver(post_save, sender=Image)
def create_image_versions(sender, instance: 'Image', created: bool, **kwargs):
    """
    Connect the generate_image_versions function to the post_save signal
    for the Image model.
    """
    if created and instance.file:
        task_name_image_versions = f"photo-versions-generation-id-{instance.id}"
        task_similar_images_detection = f"similar-photos-discovery-id-{instance.id}"
        async_task(generate_image_versions, instance, task_name=task_name_image_versions)
        async_task(detect_image_duplicates, instance, task_name=task_similar_images_detection)

def generate_image_versions(instance):
    ImageManager().process_image_versions(instance)
    
def detect_image_duplicates(queryset):
    ImageManager().detect_duplicates(queryset)
    
@receiver(post_delete, sender=Trash)
def delete_orphaned_media(sender, instance, **kwargs):
    """
    Delete orphaned media files when the associated Trash instance is deleted.
    """
    if instance.content_object:
        content_type = ContentType.objects.get_for_model(instance.content_object)
        orphaned_media = Media.objects.filter(
            content_type=content_type,
            object_id=instance.content_object.pk,
            is_orphan=True
        )
        for media in orphaned_media:
            media.hard_delete()

    instance.content_object.hard_delete()
    
