from app.serializers import BaseSerializer
from media.serializers import ImageSerializer
from .models import Event
from media.models import Image

class EventSerializer(BaseSerializer):
    image = ImageSerializer()

    class Meta:
        model = Event
        fields = ('id', 'title', 'description','image','start_date','end_date','location')