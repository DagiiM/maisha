from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ImageViewSet, DocumentViewSet, VideoViewSet,IconViewSet
from app.urls import router

router.register('images', ImageViewSet, basename='image')
router.register('icons', IconViewSet, basename='icon')
router.register('documents', DocumentViewSet, basename='document')
router.register('videos', VideoViewSet, basename='video')

urlpatterns = [
    path('api/', include(router.urls)),
]
