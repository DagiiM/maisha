
from .views import ProgramViewSet,RecentVerifiedAboutProgramsView
from django.urls import path, include
from app.urls import router

router.register(r'programs', ProgramViewSet,basename='program')
router.register('programs/(?P<program_pk>\d+)/activities', ProgramViewSet,basename='activity')

urlpatterns = [
    path('api/', include(router.urls)),
    path('api/recent-verified-about-programs/', RecentVerifiedAboutProgramsView.as_view(), name='recent-verified-about-us'),
]
