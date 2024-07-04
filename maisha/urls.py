
from django.contrib import admin
from django.urls import path,include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',include('client.urls')),
    path('',include('media.urls')),
    path('',include('trash.urls')),
    path('',include('search.urls')),
    path('',include('about.urls')),
    path('',include('events.urls')),
    path('',include('contact.urls')),
    path('',include('partnership.urls')),
    path('',include('programs.urls')),
    path('ckeditor/', include('ckeditor_uploader.urls')),
  
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

 