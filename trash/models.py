from django.db import models
from django.utils import timezone
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType
from datetime import timedelta

    
class SoftDeleteModel(models.Model):
    """

    Args:
        models (_type_): _description_
    """
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    deleted_at = models.DateTimeField(blank=True, null=True, editable=False)
    
    deletion_scheduled = models.BooleanField(default=False)
    deletion_date = models.DateTimeField(blank=True, null=True, editable=False)
    
    
    class Meta:
        abstract = True
        
    def delete(self, using=None, keep_parents=False):
        """
        Override the delete method to perform soft deletion.
        """
        self.is_deleted = True
        self.deletion_scheduled = True
        self.deleted_at = timezone.now()
        self.deletion_date = timezone.now() + timedelta(days=30)
        self.save(using=using)
        self.create_trash_instance()

    def hard_delete(self, using=None, keep_parents=False):
        """
        Method for hard deletion (completely removing from the database).
        """
        super().delete(using=using, keep_parents=keep_parents)
        
    def restore(self, using=None, keep_parents=False):
        """
        Restore a soft-deleted instance.
        """
        obj = self.content_type.get_object_for_this_type(pk=self.object_id)
        obj.is_deleted = False
        obj.is_deleted = False
        obj.deletion_scheduled = False
        obj.deletion_date = None
        obj.deleted_at = None
        obj.save()
        super().delete(using=using, keep_parents=keep_parents)
        
    def create_trash_instance(self):
        if not isinstance(self, Trash):
            Trash.objects.create(content_object=self, deletion_date=self.deletion_date)


class Trash(SoftDeleteModel,models.Model):
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey('content_type', 'object_id')
    deletion_date = models.DateTimeField(blank=True, null=True, editable=False)

    class Meta:
        ordering = ['-deletion_date']
        verbose_name_plural = 'Recycle Bin'

