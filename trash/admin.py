from django.contrib import admin
from .models import Trash
from app.admin import BaseAdmin
from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html

@admin.register(Trash)
class TrashAdmin(BaseAdmin):
    list_display = ('content_object','content_object_link','deletion_date')
    readonly_fields = ['content_type','object_id','deletion_date']
    list_filter = ('deletion_scheduled',)
    actions = ['restore_selected']
    

    def content_object_link(self, obj):
        related_model = obj.content_object.__class__
        if related_model in admin.site._registry:
            admin_class = admin.site._registry[related_model]
            link_url = self.get_admin_url(obj.content_object)
            try:
                # Get the string representation of the related object
                related_object_str = str(obj.content_object)
            except Exception:
                # Use the model name as a fallback
                related_object_str = related_model._meta.verbose_name
            return format_html('<a href="{}">{}</a>', link_url, related_object_str)
        else:
            return str(obj.content_object)
    content_object_link.short_description = 'Preview Link'
    content_object_link.admin_order_field = 'content_object'

    def get_admin_url(self, obj):
        """
        Returns the URL to the admin page of the given object.
        """
        content_type = obj._meta.app_label + '_' + obj._meta.model_name
        try:
            return reverse(f'admin:{content_type}_change', args=[obj.id])
        except Exception:
            try:
                return reverse(f'admin:{obj._meta.app_label}_{obj._meta.model_name}_change', args=[obj.id])
            except Exception:
                return '#'
    
    def restore_selected(modeladmin, request, queryset):
        # Soft delete selected instances
        for obj in queryset:
            obj.restore()
            
    restore_selected.short_description = "Restore selected items"
    
    def has_add_permission(self, request):
        # Disable the ability to add new Trash items
        return False

    def has_change_permission(self, request, obj=None):
        # Disable the ability to change existing Trash items
        return False