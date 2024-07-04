from .serializers import ImageSerializer, DocumentSerializer, VideoSerializer, IconSerializer
from app.views import BaseViewSet
from rest_framework.decorators import action
from rest_framework.response import Response

class ImageViewSet(BaseViewSet):
    serializer_class = ImageSerializer
    
    @action(detail=False, methods=['GET'])
    def featured_images(self, request):
        """
        Retrieve a list of featured images.
        """
        featured_images = self.get_queryset().filter(featured=True)
        page = self.paginate_queryset(featured_images)

        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(featured_images, many=True)
        return Response(serializer.data)


class DocumentViewSet(BaseViewSet):
    serializer_class = DocumentSerializer

class VideoViewSet(BaseViewSet):
    serializer_class = VideoSerializer


class IconViewSet(BaseViewSet):
    serializer_class = IconSerializer