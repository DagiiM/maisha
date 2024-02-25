from rest_framework import viewsets
from .pagination import CustomPagination

class BaseViewSet(viewsets.ReadOnlyModelViewSet):
    """
    A base viewset that provides default queryset, serializer_class, and pagination_class.
    """
    serializer_class = None
    pagination_class = CustomPagination
    ordering = '-pk'

    def get_queryset(self):
        """
        Returns the queryset that should be used for list views.
        """
        if self.serializer_class:
            model = self.serializer_class.Meta.model
            return model.objects.all().order_by(self.ordering)
        return None

    def get_serializer_context(self):
        """
        Returns the context dictionary that should be passed to the serializer.
        """
        context = super().get_serializer_context()
        context['request'] = self.request
        return context

    def get_paginated_response(self, data):
        """
        Return a paginated style response for list views.
        """
        return self.paginator.get_paginated_response(data)
    
    def get_serializer_class(self):
        """
        Returns the serializer class that should be used for the request.
        """
        if self.action == 'list':
            return self.serializer_class
        return self.serializer_class