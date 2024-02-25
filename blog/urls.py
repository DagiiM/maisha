from django.urls import path, include
from .views import BlogViewSet
from app.urls import router

router.register(r'blogs', BlogViewSet,basename='blog')

urlpatterns = [
    path('api/', include(router.urls)),
]
