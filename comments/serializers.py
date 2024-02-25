from app.serializers import BaseSerializer
from .models import Comment

class CommentSerializer(BaseSerializer):
    class Meta:
        model = Comment
        fields = '__all__'
