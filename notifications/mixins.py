from django.contrib.auth import get_user_model
from django.db import models
from django.contrib.contenttypes.fields import GenericRelation

class Notifiable(models.Model):
    notifications = GenericRelation('Notification', related_query_name='notifiable')

    class Meta:
        abstract = True  # Ensures Notifiable does not create a separate table.

    def notify(self, recipient, message):
        """Create a notification for a single recipient."""
        Notification.objects.create(
            recipient=recipient,
            message=message,
            content_object=self
        )

    @staticmethod
    def notify_all(message, excluding_user=None):
        """
        Create a notification for all users in the system, with an option to exclude a specific user.
        
        :param message: The notification message to be sent.
        :param excluding_user: A User instance to be excluded from receiving the notification, if any.
        """
        User = get_user_model()  # Get the default user model
        recipients = User.objects.all()
        if excluding_user is not None:
            recipients = recipients.exclude(id=excluding_user.id)

        notifications = [
            Notification(
                recipient=user,
                message=message,
            ) for user in recipients
        ]
        Notification.objects.bulk_create(notifications)  # Use bulk_create for efficiency

class NotificationFilterMixin(models.Model):
    class Meta:
        abstract = True

    @staticmethod
    def unread_for_user(user):
        return Notification.objects.filter(recipient=user, read=False)

    @staticmethod
    def for_model(model_type):
        return Notification.objects.filter(content_type__model=model_type)


class TypedNotificationMixin(models.Model):
    NOTIFICATION_TYPES = (
        ('info', 'Information'),
        ('warning', 'Warning'),
        ('alert', 'Alert'),
    )
    notification_type = models.CharField(max_length=10, choices=NOTIFICATION_TYPES, default='info')

    class Meta:
        abstract = True

class BulkNotificationHandlerMixin(models.Model):
    class Meta:
        abstract = True

    @staticmethod
    def mark_all_as_read(user):
        Notification.objects.filter(recipient=user).update(read=True)

    @staticmethod
    def delete_all_for_user(user):
        Notification.objects.filter(recipient=user).delete()

class UserNotificationPreferencesMixin(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    receive_email_notifications = models.BooleanField(default=True)
    receive_sms_notifications = models.BooleanField(default=False)

    class Meta:
        abstract = True
