from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Blog
from comments.forms import CommentForm
from media.forms import VideoForm, DocumentForm, ImageForm
from django.contrib.contenttypes.models import ContentType

@receiver(post_save, sender=Blog)
def create_associated_content(sender, instance, created, **kwargs):
    if created:
        # Extract object_id from the created BlogPost instance
        object_id = instance.id

        # Create associated content with content_type and object_id
        image_form = ImageForm(data={'content_type': ContentType.objects.get_for_model(instance).id, 'object_id': object_id})
        comment_form = CommentForm(data={'content_type': ContentType.objects.get_for_model(instance).id, 'object_id': object_id})
        video_form = VideoForm(data={'content_type': ContentType.objects.get_for_model(instance).id, 'object_id': object_id})
        document_form = DocumentForm(data={'content_type': ContentType.objects.get_for_model(instance).id, 'object_id': object_id})

        if (
            image_form.is_valid() and
            comment_form.is_valid() and
            video_form.is_valid() and
            document_form.is_valid()
        ):
            image_form.save()
            comment_form.save()
            video_form.save()
            document_form.save()
