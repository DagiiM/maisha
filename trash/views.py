from app.views import BaseViewSet
from .serializers import TrashSerializer

class TrashViewSet(BaseViewSet):
    serializer_class = TrashSerializer
