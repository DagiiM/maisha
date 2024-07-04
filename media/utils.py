from django.db import models
from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver

class OrphanTrackingField(models.PositiveBigIntegerField):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def pre_save(self, model_instance, add):
        return super().pre_save(model_instance, add)

    def post_save(self, model_instance, created, update_fields, raw):
        if self.attname == 'object_id':
            model_instance.is_orphan = model_instance.object_id is None
            model_instance.save(update_fields=['is_orphan'])
        super().post_save(model_instance, created, update_fields, raw)
