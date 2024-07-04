from app.views import BaseViewSet
from .serializers import EventSerializer

class EventViewSet(BaseViewSet):
    serializer_class = EventSerializer