from app.serializers import BaseSerializer
from media.serializers import ImageSerializer
from .models import Partner,TeamMember
from django.contrib.auth.models import User
from contact.serializers import ContactInformationSerializer

class UserSerializer(BaseSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name']
        read_only_fields = ['id']

        
class PartnerSerializer(BaseSerializer):
    image = ImageSerializer()
    contact_info = ContactInformationSerializer()
    class Meta:
        model = Partner
        fields = '__all__'
        
class TeamMemberSerializer(BaseSerializer):
    user = UserSerializer()
    image = ImageSerializer()
    contact_info = ContactInformationSerializer()
    
    class Meta:
        model = TeamMember
        fields = '__all__'