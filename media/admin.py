
from django.contrib import admin
from .models import Image, Document, Video,Icon
from .forms import DocumentForm,VideoForm,ImageForm,IconForm
from app.admin import BaseAdmin
from django.contrib.contenttypes.models import ContentType
from django.db.models import ForeignKey
from trash.models import Trash
from django.utils.safestring import mark_safe
from django.contrib import admin
from django.contrib import messages
from django.db import models
import os
from .managers import ImageManager
from django.contrib import admin
from .models import Image,SimilarPhoto
from django.db.models import Subquery

class DuplicateFilter(admin.SimpleListFilter):
    title = 'Duplicates'
    parameter_name = 'duplicates'

    def lookups(self, request, model_admin):
        return (
            ('yes', 'Yes'),
            ('no', 'No'),
        )

    def queryset(self, request, queryset):
        if self.value() == 'yes':
            return Image.detect_duplicates(queryset)
        elif self.value() == 'no':
            all_ids = queryset.values_list('id', flat=True)
            duplicates = Image.detect_duplicates(queryset).values_list('id', flat=True)
            return queryset.exclude(id__in=duplicates)
        return queryset

    
class MediaAdmin(BaseAdmin):
    list_filter = ('is_orphan','is_deleted')
    
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if isinstance(db_field, ForeignKey) and db_field.name == 'content_type':
            # Get the model class (e.g., Image, Document, or Video)
            model_class = self.model
            # Get a queryset of models that have a ForeignKey relationship with the current model
            related_models = [field.related_model for field in model_class._meta.get_fields() if field.one_to_many]
            # Exclude Trash model
            related_models = [model for model in related_models if model != Trash]
            # Get the content types of related models
            content_types = ContentType.objects.filter(model__in=[related_model._meta.model_name for related_model in related_models])
            # Prepopulate the choices for the content_type field with the names of related models
            kwargs["queryset"] = content_types

        return super().formfield_for_foreignkey(db_field, request, **kwargs)
    

    
@admin.register(Image)
class ImageAdmin(MediaAdmin):
    model = Image
    form = ImageForm
    list_display = ('id', 'thumbnail', 'caption', 'featured', 'is_orphan')
    search_fields = ('caption',)
    list_filter = MediaAdmin.list_filter + ('featured',DuplicateFilter)
    readonly_fields = MediaAdmin.readonly_fields + ['versions', 'is_orphan','similarity_explored']
    
    
@admin.register(Document)
class DocumentAdmin(MediaAdmin):
    model = Document
    form = DocumentForm
    
@admin.register(Video)
class VideoAdmin(MediaAdmin):
    model = Video
    form = VideoForm
    
@admin.register(Icon)
class IconAdmin(MediaAdmin):
    model = Icon
    form = IconForm

    list_display = ('id', 'name',) 
    

from django.utils.html import format_html

@admin.register(SimilarPhoto)
class SimilarPhotoAdmin(admin.ModelAdmin):
    list_display = ('id','image_previews')  # Add 'image_previews'
    #search_fields = ('id',)
    #list_filter = ('created_at',)

    def get_queryset(self, request):
        return super().get_queryset(request)
    

    def image_previews(self, obj):
        """
        Display image previews for the DuplicateImageCluster instance with lightbox.
        """
        images = obj.images.all()
        if images:
            previews_html = ''
            for image in images:
                if image.versions:  # Check if versions exist
                    # Assuming 'thumbnail' is one of the version keys, change it to your actual version key
                    thumbnail_url = image.versions.get('thumbnail')
                    large_url = image.versions.get('large')  # Assuming you have a 'large' version
                    if thumbnail_url and large_url:
                        lightbox_id = f"eleso-lightbox-{image.id}"
                        previews_html += f'<a href="{large_url}" data-lightbox-id="{lightbox_id}">'
                        previews_html += f'<img src="{thumbnail_url}" loading="lazy" class="image-preview" style="max-width:100px; max-height:100px; margin:5px;border:1px solid rgb(191, 59, 141)" alt="{thumbnail_url}"/>'
                        previews_html += '</a>'
                else:
                    # If versions don't exist, fallback to the original image URL
                    previews_html += f'<a href="{image.file.url}" data-lightbox-id="{lightbox_id}">'
                    previews_html += f'<img src="{image.file.url}" loading="lazy" class="image-preview" style="max-width:100px; max-height:100px; margin:5px;border:1px solid rgb(191, 59, 141)" alt="{image.file.url}"/>'
                    previews_html += '</a>'
            return format_html(previews_html)
        else:
            return '-'

    image_previews.short_description = 'Image Previews'
    image_previews.allow_tags = True
