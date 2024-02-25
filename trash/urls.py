from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import  TrashViewSet

router = DefaultRouter()
router.register(r'trash', TrashViewSet, basename='trash')

urlpatterns = [
    path('api/', include(router.urls)),
]
