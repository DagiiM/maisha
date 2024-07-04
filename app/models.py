from django.contrib.contenttypes.fields import GenericRelation,GenericForeignKey
from search.models import SearchableModel
from trash.models import Trash,SoftDeleteModel

from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.core.exceptions import ValidationError
from django.utils import timezone


class Manager(models.Manager):
        def get_queryset(self):
            return super().get_queryset().filter(is_deleted=False)#,deleted_at__isnull=True)

    
class BaseModel(SoftDeleteModel,SearchableModel):
    trash_items = GenericRelation(Trash)
    is_deleted = models.BooleanField(default=False, verbose_name='Deleted')
    
    objects = Manager()
    
    class Meta:
        abstract = True
        
    def validate_start_end_dates(self, value):
        """
        Validate that the provided value (date or datetime) is not in the past.
        Raises a ValidationError if the value is in the past.
        """
        if value < timezone.now():
            raise ValidationError('Start date cannot be in the past.')


class SharedModel(BaseModel):
    content = models.TextField()
    content_type = models.ForeignKey(ContentType,on_delete=models.CASCADE,help_text='The content type of the target model.')
    object_id = models.PositiveIntegerField(help_text='The ID of the target model.')
    related_object = GenericForeignKey('content_type','object_id')   
    
    class Meta:
        abstract = True