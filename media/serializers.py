from rest_framework import serializers
from .models import Image, Document, Video
from django.conf import settings

class ImageSerializer(serializers.ModelSerializer):
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

class DocumentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Document
        fields = '__all__'

class VideoSerializer(serializers.ModelSerializer):
    poster = ImageSerializer()
    class Meta:
        model = Video
        fields = '__all__'
