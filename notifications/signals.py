from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Notification

@receiver(post_save, sender=User)
def send_notification_on_user_creation(sender, instance, created, **kwargs):
    if created:
        message = "Welcome to our platform! We're glad to have you."
        Notification.notify(instance, message)
