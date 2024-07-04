from django.urls import path
from .views import welcome,design,completed,canceled,ways_to_support,contact,about,program,blog,why_maisha,service,privacy_policy

urlpatterns = [
    path('', welcome, name='welcome'),
    path('about/', about, name='about'),
    path('ways-to-support/', ways_to_support, name='ways_to_support'),
    path('why-maisha/', why_maisha, name='why_maisha'),
    path('services/', service, name='service'),
    path('contact/', contact, name='contact'),
    path('privacy-policy/', privacy_policy, name='privacy_policy'),
    
    path('blog/', blog, name='blog'),
    path('donations/completed',completed,name='completed'),
    path('donations/cancel',canceled,name='canceled'),
    path('program/', program, name='program'),
    path('designs/', design, name='design'),
    path('program/<int:program_id>/', program, name='program_detail'),  # program_id specified
]
