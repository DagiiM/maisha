from django.urls import path, include
from .views import RecentVerifiedAboutView,RecentVerifiedAboutOrganizationView,SystemSettingsViewSet
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'system-settings', SystemSettingsViewSet, basename='system-settings')

urlpatterns = [
    path('api/recent-verified-about-us/', RecentVerifiedAboutView.as_view(), name='recent-verified-about-us'),
    path('api/recent-verified-about-organization/', RecentVerifiedAboutOrganizationView.as_view(), name='recent-verified-about-us'),
    path('api/', include(router.urls)),
]
