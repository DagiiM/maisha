from django.contrib import admin
from .models import Image, Document, Video
from .forms import DocumentForm,VideoForm,ImageForm
from app.admin import BaseAdmin
from django.contrib.contenttypes.models import ContentType
from django.db.models import ForeignKey
from trash.models import TrashItem

class MediaAdmin(BaseAdmin):
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if isinstance(db_field, ForeignKey) and db_field.name == 'content_type':
            # Get the model class (e.g., Image, Document, or Video)
            model_class = self.model
            # Get a queryset of models that have a ForeignKey relationship with the current model
            related_models = [field.related_model for field in model_class._meta.get_fields() if field.one_to_many]
            # Exclude TrashItem model
            related_models = [model for model in related_models if model != TrashItem]
            # Get the content types of related models
            content_types = ContentType.objects.filter(model__in=[related_model._meta.model_name for related_model in related_models])
            # Prepopulate the choices for the content_type field with the names of related models
            kwargs["queryset"] = content_types
            '''
        elif db_field.name == 'object_id':
            # Get the selected content_type
            content_type = kwargs.get('form', None).instance.content_type
            # Get the model class corresponding to the selected content_type
            if content_type:
                model_class = content_type.model_class()
                # Get instances of the selected model and populate choices
                kwargs['queryset'] = model_class.objects.all()
                '''
        return super().formfield_for_foreignkey(db_field, request, **kwargs)
    
@admin.register(Image)
class ImageAdmin(MediaAdmin):
    model = Image
    form = ImageForm

    list_display = ('id', 'caption', 'featured', 'get_file_url') 
    search_fields = ('caption',)
    readonly_fields = ['versions']
 

    
@admin.register(Document)
class DocumentAdmin(MediaAdmin):
    model = Document
    form = DocumentForm
    
    
@admin.register(Video)
class VideoAdmin(MediaAdmin):
    model = Video
    form = VideoForm
    