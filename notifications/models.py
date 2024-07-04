from django.db import models
from django.contrib.auth.models import User
from django.contrib.contenttypes.fields import GenericForeignKey, GenericRelation
from django.contrib.contenttypes.models import ContentType
from .mixins import Notifiable, NotificationFilterMixin, TypedNotificationMixin, BulkNotificationHandlerMixin, UserNotificationPreferencesMixin

class NotificationManager(models.Manager):
    def unread_for_user(self, user):
        return self.filter(recipient=user, read=False)

    def mark_as_read(self, notification):
        notification.read = True
        notification.save()

class Notification(Notifiable, NotificationFilterMixin, TypedNotificationMixin, BulkNotificationHandlerMixin, models.Model):
    recipient = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
    message = models.TextField()
    read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE, null=True, blank=True)
    object_id = models.PositiveIntegerField(null=True, blank=True)
    content_object = GenericForeignKey('content_type', 'object_id')

    objects = NotificationManager()

class UserNotificationPreferences(UserNotificationPreferencesMixin):
    def __str__(self):
        return f"Notification Preferences for {self.user.username}"
