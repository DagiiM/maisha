from app.views import BaseViewSet
from .serializers import TrashItemSerializer

class TrashViewSet(BaseViewSet):
    serializer_class = TrashItemSerializer
