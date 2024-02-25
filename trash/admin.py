from django.contrib import admin
from .models import TrashItem

class TrashItemAdmin(admin.ModelAdmin):
    list_display = ('content_object','deleted_at')

admin.site.register(TrashItem, TrashItemAdmin)
