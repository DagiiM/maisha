from app.views import BaseViewSet
from .serializers import CommentSerializer

class CommentViewSet(BaseViewSet):
    serializer_class = CommentSerializer

    # Add any custom actions or permissions as needed
