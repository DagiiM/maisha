from django.contrib import admin
from django.conf import settings
from django.utils.translation import gettext_lazy as _
from django.utils.safestring import mark_safe

class MyAdminSite(admin.AdminSite):
    site_header = settings.APP_NAME
    site_title = settings.APP_DOMAIN
    index_title = settings.APP_TAGLINE

    
class BaseAdminWithThumbnail(admin.ModelAdmin):
    def get_thumbnail_url(self, obj):
        if any(hasattr(obj, attr) for attr in ('file', 'image')):
            try:
                if hasattr(obj, 'file'):
                    image_versions = obj.versions
                elif hasattr(obj, 'image'):
                    image_versions = obj.image.versions
                else:
                    raise AttributeError("Object does not have 'file' or 'image' attribute")

                if image_versions:
                    thumbnail_url = image_versions.get('thumbnail', '')
                    large_url = image_versions.get('large', '')
                    return thumbnail_url, large_url
            except AttributeError:
                pass

        return '', ''

    def thumbnail(self, obj):
        lightbox_id = f"eleso-lightbox-{obj.id}"
        thumbnail_url, large_url = self.get_thumbnail_url(obj)
        if thumbnail_url and large_url:
            return mark_safe(f'<a href="{large_url}" data-lightbox-id="{lightbox_id}"><img src="{thumbnail_url}" loading="lazy" style="width: 50px; height: auto;"></a>')
        return 'No image'

    thumbnail.short_description = 'Thumbnail'
    thumbnail.allow_tags = True
    
       
class BaseAdmin(BaseAdminWithThumbnail):
    actions = ['soft_delete_selected']
    readonly_fields = ['deletion_scheduled','is_deleted']
    
    def get_queryset(self, request):
        # Exclude soft-deleted instances from the queryset
        return super().get_queryset(request).filter(deletion_scheduled=False)

    def soft_delete_selected(modeladmin, request, queryset):
        # Soft delete selected instances
        for obj in queryset:
            obj.delete()
            
    soft_delete_selected.short_description = "Soft delete selected items"
    
    
    def get_actions(self, request):
        # Exclude the default delete action
        actions = super().get_actions(request)
        del actions['delete_selected']
        return actions