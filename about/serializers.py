from rest_framework import serializers
from .models import About,SystemSettings
from app.serializers import BaseSerializer
from media.serializers import ImageSerializer

class AboutSerializer(BaseSerializer):
    image = ImageSerializer()
    class Meta:
        model = About
        fields = ('content', 'is_verified','image')
        
class SystemSettingsSerializer(BaseSerializer):
    class Meta:
        model = SystemSettings
        fields = ('enable_email_notifications','use_original_images','enable_caching','enable_two_factor_auth','maintenance_mode')