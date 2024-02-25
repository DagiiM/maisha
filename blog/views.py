from app.views import BaseViewSet
from .serializers import BlogSerializer

class BlogViewSet(BaseViewSet):
    serializer_class = BlogSerializer

    def get_queryset(self):
        queryset = super().get_queryset()
        return queryset.order_by('-publication_date')