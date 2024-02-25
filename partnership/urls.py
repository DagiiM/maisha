
from .views import PartnerViewSet,TeamViewSet,RecentVerifiedAboutPartnersView
from django.urls import path, include
from rest_framework.routers import DefaultRouter

# Create a router
router = DefaultRouter()
router.register(r'partners', PartnerViewSet,basename='partner')
router.register(r'team', TeamViewSet,basename='team')


urlpatterns = [
    path('api/', include(router.urls)),
    path('api/recent-verified-about-partners/', RecentVerifiedAboutPartnersView.as_view(), name='recent-verified-about-us'),

]
