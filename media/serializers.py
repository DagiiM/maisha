from rest_framework import serializers
from .models import Image, Document, Video, Icon
from django.conf import settings
from app.serializers import BaseSerializer

class ImageSerializer(BaseSerializer):
    versions = serializers.SerializerMethodField()

    class Meta:
        model = Image
        fields = ['id', 'file', 'caption', 'featured', 'versions']
        read_only_fields = ['id', 'file', 'caption', 'featured', 'versions']

    def get_versions(self, obj):
        request = self.context.get('request')
        if obj.versions:
            return {key: request.build_absolute_uri(value) for key, value in obj.versions.items()}
        else:
            return {}

    def to_representation(self, instance):
        ret = super().to_representation(instance)
        if 'request' in self.context:
            request = self.context['request']
            ret['file'] = request.build_absolute_uri(settings.MEDIA_URL + str(instance.file))
        return ret

class DocumentSerializer(BaseSerializer):
    class Meta:
        model = Document
        fields = '__all__'

class IconSerializer(BaseSerializer):
    class Meta:
        model = Icon
        fields = '__all__'
        
class VideoSerializer(BaseSerializer):
    poster = ImageSerializer()
    class Meta:
        model = Video
        fields = '__all__'
