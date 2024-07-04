from django.contrib import admin
from .models import About, AboutRelationship
from .forms import AboutForm
from app.admin import BaseAdmin
from django.contrib import admin
from .models import SystemSettings

@admin.register(SystemSettings)
class SystemSettingsAdmin(admin.ModelAdmin):
    list_display = (
        'site_title',
        'maintenance_mode',
    )

    fieldsets = (
        ('General Settings', {
            'fields': (
                'site_title',
                #'site_logo',
            )
        }),
        ('Branding Settings', {
            'fields': (
                'primary_color',
                'secondary_color',
            )
        }),
        ('Email Settings', {
            'fields': (
                'email_from',
                'email_host',
                'email_port',
                'email_username',
                'email_password',
            )
        }),
        ('Notification Settings', {
            'fields': (
                'enable_email_notifications',
                'notification_email_recipients',
            )
        }),
        ('Image Settings', {
            'fields': (
                'use_original_images',
                'image_quality',
                'image_max_size',
            )
        }),
        ('Caching Settings', {
            'fields': (
                'enable_caching',
                'cache_timeout',
                'cache_backend',
            )
        }),
        ('Logging Settings', {
            'fields': (
                'log_level',
                'log_file_path',
                'log_file_size_limit',
            )
        }),
        ('Authentication and Authorization Settings', {
            'fields': (
                'enable_two_factor_auth',
                'allowed_ip_ranges',
                'session_timeout',
            )
        }),
        ('Data Retention Settings', {
            'fields': (
                'data_retention_period',
                'enable_data_archiving',
                'archive_storage_location',
            )
        }),
        ('Miscellaneous Settings', {
            'fields': (
                'maintenance_mode',
            )
        }),
    )
    # save_on_top = True
    # save_as = True
    
    def has_delete_permission(self, request, obj=None):
        return False

    def has_add_permission(self, request, obj=None):
        return False

    def get_actions(self, request):
        actions = super().get_actions(request)
        if 'delete_selected' in actions:
            del actions['delete_selected']
        return actions
    
@admin.register(About)
class AboutAdmin(BaseAdmin):
    form = AboutForm
    list_display = ('content_type','thumbnail','is_verified')
    
admin.site.register(AboutRelationship)
