
from app.views import BaseViewSet
from .serializers import PartnerSerializer, TeamMemberSerializer
from rest_framework.generics import ListAPIView
from about.models import About
from about.serializers import AboutSerializer
from django.contrib.contenttypes.models import ContentType
from .models import Partner

class PartnerViewSet(BaseViewSet):
    serializer_class = PartnerSerializer
    
class RecentVerifiedAboutPartnersView(ListAPIView):
    serializer_class = AboutSerializer

    def get_queryset(self):
        content_type = ContentType.objects.get_for_model(Partner)  # Replace 'YourRelatedModel' with your specific model
        return About.objects.filter(
            is_verified=True,
            content_type=content_type,
            #object_id=your_object_id  # Replace 'your_object_id' with the ID of the related object
        ).order_by('-id')[:1]
        
class TeamViewSet(BaseViewSet):
    serializer_class = TeamMemberSerializer