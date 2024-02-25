from django.urls import path
from .views import welcome,completed,canceled,ways_to_support,contact,about,program,blog,why_maisha

urlpatterns = [
    path('', welcome, name='welcome'),
    path('about/', about, name='about'),
    path('ways-to-support/', ways_to_support, name='ways_to_support'),
    path('why-maisha/', why_maisha, name='why_maisha'),
    path('contact/', contact, name='contact'),
    path('blog/', blog, name='blog'),
    path('donations/completed',completed,name='completed'),
    path('donations/cancel',canceled,name='canceled'),
    path('program/', program, name='program'),
    path('program/<int:program_id>/', program, name='program_detail'),  # program_id specified
]
