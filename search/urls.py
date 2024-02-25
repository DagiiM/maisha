'''from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import  SearchViewSet

router = DefaultRouter()
router.register(r'search', SearchViewSet,basename='search')

urlpatterns = [
    path('', include(router.urls)),
]
'''

from django.urls import path
from .views import SearchAPIView

urlpatterns = [
    path('search/', SearchAPIView.as_view(), name='search'),
]
