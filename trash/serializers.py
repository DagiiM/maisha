from app.serializers import BaseSerializer
from .models import Trash

class TrashSerializer(BaseSerializer):
    class Meta:
        model = Trash
        fields = '__all__'
