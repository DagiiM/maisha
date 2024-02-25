from app.serializers import BaseSerializer
from .models import Blog
from media.serializers import ImageSerializer,VideoSerializer, DocumentSerializer
from comments.serializers import CommentSerializer
from .models import Blog, Category, Tag
from rest_framework import serializers
from django.contrib.auth.models import User

class CategorySerializer(BaseSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class TagSerializer(BaseSerializer):
    class Meta:
        model = Tag
        fields = '__all__'

class BlogSerializer(BaseSerializer):
    images = ImageSerializer(many=True, read_only=True)
    comments = CommentSerializer(many=True, read_only=True)
    videos = VideoSerializer(many=True, read_only=True)
    documents = DocumentSerializer(many=True, read_only=True)
    categories = CategorySerializer(many=True, read_only=True)
    tags = TagSerializer(many=True, read_only=True)
    author = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())

    class Meta:
        model = Blog
        fields = '__all__'  # You can specify specific fields if needed
