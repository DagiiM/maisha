from django.db import models
from django.contrib.contenttypes.fields import GenericForeignKey, GenericRelation
from django.contrib.contenttypes.models import ContentType
from ckeditor_uploader.fields import RichTextUploadingField
from media.models import Image
from app.models import SharedModel

class About(SharedModel):
    is_verified = models.BooleanField(default=False)
    image = models.ForeignKey(Image, on_delete=models.CASCADE,null=True,blank=True, help_text="Image related")

    def __str__(self):
        return self.content

    def save(self, *args, **kwargs):
        self.content = self.content.strip()
        super(About, self).save(*args, **kwargs)

    def get_content_preview(self):
        return self.content[:50]

    def get_related_object(self):
        return self.related_object

    @staticmethod
    def create_about(content, creator, related_object):
        about = About.objects.create(content=content, created_by=creator, content_type=ContentType.objects.get_for_model(related_object), object_id=related_object.id)
        AboutRelationship.objects.create(about=about, content_type=ContentType.objects.get_for_model(related_object), object_id=related_object.id)
        return about

class AboutRelationship(models.Model):
    about = models.ForeignKey(About, on_delete=models.CASCADE, related_name='relationships')
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField()
    related_object = GenericForeignKey('content_type', 'object_id')

    @staticmethod
    def relate_to_model(model_class):
        ct = ContentType.objects.get_for_model(model_class)
        about = About.objects.create(content_type=ct, object_id=model_class.pk)
        AboutRelationship.objects.create(about=about, content_type=ct, object_id=model_class.pk)
        return about

class SystemSettings(models.Model):
    """
    Model to store various system settings for a dashboard.
    """
    
    # General settings
    site_title = models.CharField(max_length=100, default="My Dashboard")
    
    # Branding settings
    primary_color = models.CharField(max_length=7, default="#007bff")
    secondary_color = models.CharField(max_length=7, default="#6c757d")
    
    # Email settings
    email_from = models.EmailField(default="noreply@maishagirlssafehouse.org")
    email_host = models.CharField(max_length=100, default="smtp.gmail.com")
    email_port = models.IntegerField(default=587)
    email_username = models.CharField(max_length=100)
    email_password = models.CharField(max_length=100)
    
    # Notification settings
    enable_email_notifications = models.BooleanField(default=True)
    notification_email_recipients = models.CharField(max_length=200, blank=True, null=True)
    
    # Image settings
    use_original_images = models.BooleanField(default=True, 
                                             help_text="If true, the original uploaded image will be displayed. If false, dynamic image versions will be used.")
    image_quality = models.IntegerField(default=80, 
                                        help_text="The quality of the dynamically generated image versions (0-100).")
    image_max_size = models.IntegerField(default=1024, 
                                         help_text="The maximum size (in pixels) of the dynamically generated image versions.")
    
    # Caching settings
    enable_caching = models.BooleanField(default=True)
    cache_timeout = models.IntegerField(default=3600, help_text="The number of seconds to cache responses.")
    cache_backend = models.CharField(max_length=50, default="redis", help_text="The cache backend to use (e.g., 'redis', 'memcached', etc.).")
    
    # Logging settings
    log_level = models.CharField(max_length=20, default="INFO", 
                                choices=[("DEBUG", "DEBUG"), ("INFO", "INFO"), ("WARNING", "WARNING"), ("ERROR", "ERROR"), ("CRITICAL", "CRITICAL")])
    log_file_path = models.CharField(max_length=200, default="/var/log/dashboard.log")
    log_file_size_limit = models.IntegerField(default=1048576, help_text="The maximum size (in bytes) of the log file before it is rotated.")
    
    # Authentication and Authorization settings
    enable_two_factor_auth = models.BooleanField(default=False)
    allowed_ip_ranges = models.CharField(max_length=200, blank=True, null=True, help_text="A comma-separated list of IP address ranges (e.g., '192.168.1.0/24,10.0.0.0/16')")
    session_timeout = models.IntegerField(default=30, help_text="The number of minutes of inactivity before a user session expires.")
    
    # Data Retention settings
    data_retention_period = models.IntegerField(default=30, help_text="The number of days to keep data before it is automatically purged.")
    enable_data_archiving = models.BooleanField(default=True)
    archive_storage_location = models.CharField(max_length=200, default="s3://my-dashboard-archive")
    
    # Miscellaneous settings
    maintenance_mode = models.BooleanField(default=False)
    
    class Meta:
        verbose_name_plural = "System Settings"
        
    def __str__(self):
        return "System Settings"