from app.views import BaseViewSet
from .serializers import ProgramSerializer, ActivitySerializer
from .models import Program
from django.shortcuts import get_object_or_404
from rest_framework.generics import ListAPIView
from about.models import About
from about.serializers import AboutSerializer
from django.contrib.contenttypes.models import ContentType

class ProgramViewSet(BaseViewSet):
    serializer_class = ProgramSerializer
    
    class ActivityViewSet(BaseViewSet):
        serializer_class = ActivitySerializer
        
        def get_queryset(self):
            program_pk = self.kwargs['program_pk']
            return Program.objects.filter(program_pk_pk=program_pk)

        def get_object(self):
            queryset = self.get_queryset()
            activity_pk = self.kwargs['pk']
            obj = get_object_or_404(queryset, pk=activity_pk)
            return obj
        
class RecentVerifiedAboutProgramsView(ListAPIView):
    serializer_class = AboutSerializer

    def get_queryset(self):
        content_type = ContentType.objects.get_for_model(Program)  # Replace 'YourRelatedModel' with your specific model
        return About.objects.filter(
            is_verified=True,
            content_type=content_type,
            #object_id=your_object_id  # Replace 'your_object_id' with the ID of the related object
        ).order_by('-id')[:1]