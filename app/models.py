from django.contrib.contenttypes.fields import GenericRelation
from search.models import SearchableModel
from trash.models import TrashItem
from django.db.models.signals import pre_delete
from django.dispatch import receiver
from django.db import models

class BaseModel(models.Model):
    trash_items = GenericRelation(TrashItem)
    soft_deleted = models.BooleanField(default=False)

    class Meta:
        abstract = True

    def delete(self, using=None, keep_parents=False):
        """
        Override the delete method to perform soft deletion.
        """
        self.soft_deleted = True
        self.save(using=using)
        TrashItem.objects.create(
        content_object=self
        )

    def hard_delete(self, using=None, keep_parents=False):
        """
        Method for hard deletion (completely removing from the database).
        """
        super().delete(using=using, keep_parents=keep_parents)
        
    def restore(self):
        """
        Restore a soft-deleted instance.
        """
        self.soft_deleted = False
        self.save()

    class Manager(models.Manager):
        def get_queryset(self):
            return super().get_queryset().filter(soft_deleted=False)

    objects = Manager()


@receiver(pre_delete,sender=BaseModel)
def soft_delete_handler(sender, instance, **kwargs):
    """
    Signal handler to soft-delete instances of models that inherit from Base.
    """
    print("1. Soft delete Handler")
    if isinstance(instance, BaseModel):
        instance.soft_delete()

@receiver(pre_delete, sender=BaseModel)
def trash_item_creation_handler(sender, instance, **kwargs):
    """
    Signal handler to create TrashItem when an instance is soft-deleted.
    """
    print("1. Trash Creation..")
    TrashItem.objects.create(
        content_object=instance
    )

# Connect the signal handlers to the appropriate signals
pre_delete.connect(soft_delete_handler, sender=BaseModel)
pre_delete.connect(trash_item_creation_handler, sender=BaseModel)