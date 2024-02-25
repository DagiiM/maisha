from django.urls import path
from .views import RecentVerifiedAboutView,RecentVerifiedAboutOrganizationView

urlpatterns = [
    path('api/recent-verified-about-us/', RecentVerifiedAboutView.as_view(), name='recent-verified-about-us'),
    path('api/recent-verified-about-organization/', RecentVerifiedAboutOrganizationView.as_view(), name='recent-verified-about-us'),

]
