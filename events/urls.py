
from .views import EventViewSet
from django.urls import path, include
from app.urls import router

router.register(r'events', EventViewSet,basename='event')

urlpatterns = [
    path('api/', include(router.urls)),
]
