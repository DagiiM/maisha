from django.contrib import admin
from django.conf import settings
from django.utils.translation import gettext_lazy as _

class MyAdminSite(admin.AdminSite):
    site_header = settings.APP_NAME
    site_title = settings.APP_DOMAIN
    #site_url = settings.APP_TAGLINE
    index_title = settings.APP_TAGLINE
    #available_apps
    
class BaseAdmin(admin.ModelAdmin):
    actions = ['soft_delete_selected']
    
    def get_queryset(self, request):
        # Exclude soft-deleted instances from the queryset
        return super().get_queryset(request).filter(soft_deleted=False)

    def soft_delete_selected(modeladmin, request, queryset):
        # Soft delete selected instances
        for obj in queryset:
            obj.delete()
    soft_delete_selected.short_description = "Soft delete selected items"