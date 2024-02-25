from app.serializers import BaseSerializer
from .models import TrashItem

class TrashItemSerializer(BaseSerializer):
    class Meta:
        model = TrashItem
        fields = '__all__'
