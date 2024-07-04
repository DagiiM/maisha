from django.db import models
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType
from .validator import custom_upload_path
from app.models import BaseModel
from .managers import ImageManager
import os,logging
import os, shutil, uuid, cv2, numpy as np
from django.db import transaction
from django.core.files.storage import default_storage
from django.conf import settings
from PIL import Image as PILImage
import tempfile


class Media(BaseModel):
    """
    Base model for media files.
    """
    file = models.FileField(upload_to=custom_upload_path, blank=True, null=True)
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField(null=True, blank=True)
    content_object = GenericForeignKey('content_type', 'object_id')
    is_orphan = models.BooleanField(default=False)
    similarity_explored = models.BooleanField(default=False)

    class Meta:
        abstract = True

    def __str__(self):
        return f"{self.content_type} - {self.object_id}"
            
    def save(self, *args, **kwargs):
        if not self.content_object:
            self.is_orphan = True
        else:
            self.is_orphan = False
        super().save(*args, **kwargs)

    def hard_delete(self, using=None, keep_parents=False):
        """
        Method for hard deletion (completely removing from the database and file system).
        """
        # Delete the main file
        self.file.delete(save=False)

        # Delete the version files
        if self.versions:
            for version_path in self.versions.values():
                full_version_path = os.path.join(settings.MEDIA_ROOT, version_path.lstrip('/'))
                if os.path.isfile(full_version_path):
                    os.remove(full_version_path)

        super().hard_delete(using=using, keep_parents=keep_parents)
    
class SimilarPhoto(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    images = models.ManyToManyField('Image', related_name='clusters')

    class Meta:
        verbose_name_plural = 'Similar Photos'
        
    def __str__(self):
        return f"Cluster {self.pk} created on {self.created_at}"  

class Image(Media):
    """
    Image model with additional fields and image versions.
    """
    caption = models.CharField(max_length=100, blank=True)
    featured = models.BooleanField(default=False)
    resize_mode = models.CharField(max_length=10, choices=[('NEAREST', 'Nearest'), ('BILINEAR', 'Bilinear'), ('BICUBIC', 'Bicubic'), ('LANCZOS', 'Lanczos')], default='BICUBIC')
    versions = models.JSONField(blank=True, null=True)
    
    search_fields = ['caption']
    fields_to_return = ['caption']
    
    class Meta:
        verbose_name_plural = 'Photos'

    @property
    def image_version_manager(self):
        return ImageManager(instance=self)
    
    def __str__(self):
        return f"Photo {self.id} - {self.caption}"
    
   

class Icon(Media):
    name = models.CharField(max_length=255, blank=True)

    search_fields = ['name']
    fields_to_return = ['name']
    
    class Meta:
        verbose_name_plural = 'Icons'
        
        
    def __str__(self):
        return f"Icon for {self.content_object}"
    
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
