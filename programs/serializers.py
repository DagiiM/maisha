from app.serializers import BaseSerializer
from media.serializers import ImageSerializer,IconSerializer
from .models import Program, Activity,Service
from media.models import Image

class ActivitySerializer(BaseSerializer):
    #program = ProgramSerializer()
    image = ImageSerializer()

    class Meta:
        model = Activity
        fields = ('id', 'title', 'description','image')
        
class ProgramSerializer(BaseSerializer):
    activities = ActivitySerializer(many=True, read_only=True)
    
    class Meta:
        model = Program
        fields = ('id', 'title', 'description', 'start_date', 'end_date', 'impact_overview', 'activities')


class ServiceSerializer(BaseSerializer):
    image = ImageSerializer()
    icon = IconSerializer()
    
    class Meta:
        model = Service
        fields = ('id', 'title', 'description','image','icon')
