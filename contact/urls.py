# urls.py
from . import views
from django.urls import path, include
from app.urls import router
from .views import OrganizationStepViewSet

router.register(r'organizations', views.OrganizationViewSet,basename='organization')
router.register(r'contacts', views.ContactViewSet,basename='contact-api')
router.register(r'quotes', views.QuoteViewSet,basename='quote')
router.register(r'organization-steps', OrganizationStepViewSet,basename='organization-step')


urlpatterns = [
    path('subscribe/', views.subscribe, name='subscribe'),
    path('thank-you/<str:unique_url>/', views.thank_you_page, name='thank_you_page'),
    path('error/', views.error_page, name='error_page'),

    
    path('api/', include(router.urls))
    # Add more URLs for your views as needed
]

