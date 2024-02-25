from django.db import models
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType
from .validator import custom_upload_path
from app.models import BaseModel
from django.core.exceptions import ValidationError


class Media(BaseModel):
    """
    Base model for media files.
    """
    file = models.FileField(upload_to=custom_upload_path, blank=True, null=True)
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    #object_id = models.PositiveIntegerField(choices=[],blank=True,null=True)
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey('content_type', 'object_id')

    class Meta:
        abstract = True

    def __str__(self):
        return f"{self.content_type} - {self.object_id}"

    def get_file_url(self) -> str:
        if self.file:
            return self.file.url
        return ""

    def delete_file(self) -> None:
        if self.file:
            self.file.delete()
            '''
    def save(self, *args, **kwargs):
        """
        Override the save method to set queryset for object_id.
        """
        if not self.pk and self.content_type and self.content_object:
            # If the instance is being saved for the first time and content_type and content_object are set
            # Set the queryset for object_id based on the related model
            model_class = self.content_type.model_class()
            self.object_id = model_class.objects.filter(pk=self.content_object.pk).values_list('pk', flat=True).first()
        super().save(*args, **kwargs)
        '''
class Image(Media):
    """
    Image model with additional fields and image versions.
    """
    caption = models.CharField(max_length=255, blank=True)
    featured = models.BooleanField(default=False)
    resize_mode = models.CharField(max_length=10, choices=[('NEAREST', 'Nearest'), ('BILINEAR', 'Bilinear'), ('BICUBIC', 'Bicubic'), ('LANCZOS', 'Lanczos')], default='BICUBIC')
    versions = models.JSONField(blank=True, null=True)
    
    search_fields = ['caption']
    fields_to_return = ['caption']

    def __str__(self):
        return f"Image {self.id} - {self.caption}"


class Document(Media):
    title = models.CharField(max_length=255, blank=True)
    description = models.CharField(max_length=255, blank=True)

    search_fields = ['title']
    fields_to_return = ['title']
    
    def __str__(self):
        return f"Document for {self.content_object}"
    
class Video(Media):
    description = models.CharField(max_length=255, blank=True)
    poster = models.ForeignKey(Image, on_delete=models.SET_NULL, null=True, blank=True)

    search_fields = ['description']
    fields_to_return = ['description']
    
    def __str__(self):
        return f"Video for {self.content_object}"
