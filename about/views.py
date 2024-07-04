from rest_framework.generics import ListAPIView
from .models import About
from .serializers import AboutSerializer
from django.contrib.contenttypes.models import ContentType
from contact.models import Organization
from rest_framework import viewsets
from .models import SystemSettings
from .serializers import SystemSettingsSerializer


class RecentVerifiedAboutView(ListAPIView):
    serializer_class = AboutSerializer

    def get_queryset(self):
        content_type = ContentType.objects.get_for_model(About)  # Replace 'YourRelatedModel' with your specific model
        return About.objects.filter(
            is_verified=True,
            content_type=content_type,
            #object_id=your_object_id  # Replace 'your_object_id' with the ID of the related object
        ).order_by('-id')[:1]

class RecentVerifiedAboutOrganizationView(ListAPIView):
    serializer_class = AboutSerializer

    def get_queryset(self):
        content_type = ContentType.objects.get_for_model(Organization)  # Replace 'YourRelatedModel' with your specific model
        return About.objects.filter(
            is_verified=True,
            content_type=content_type,
            #object_id=your_object_id  # Replace 'your_object_id' with the ID of the related object
        ).order_by('-id')[:1]
        


class SystemSettingsViewSet(viewsets.ModelViewSet):
    queryset = SystemSettings.objects.all()
    serializer_class = SystemSettingsSerializer

    def get_object(self):
        # Ensure there is only one instance of SystemSettings
        return SystemSettings.objects.first()

    def perform_create(self, serializer):
        # Prevent creating new instances of SystemSettings
        pass

    def perform_update(self, serializer):
        pass

    def perform_destroy(self, instance):
        # Prevent deleting the SystemSettings instance
        pass