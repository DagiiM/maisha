from django import forms
from .models import Image, Document, Video, Media,Icon
from django.utils.safestring import mark_safe
from django.template.loader import render_to_string

class MediaForm(forms.ModelForm):
    class Meta:
        model = Media
        fields = '__all__'
      
class ImageForm(MediaForm):
    class Meta:
        model = Image
        fields = '__all__'
        labels = {
            'caption': 'Caption',
            'featured': 'Featured',
            'file': 'Image File',
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if 'file' in self.fields:
            self.fields['file'].widget = LightboxImagePreviewWidget() 
            
class LightboxImagePreviewWidget(forms.ClearableFileInput):
    template_name = 'admin/custom_widgets/lightbox_image_preview_widget.html'

    def get_context(self, name, value, attrs):
        context = super().get_context(name, value, attrs)
        context['lightbox_id'] = attrs.get('id', 'image-lightbox')  # Default id if not provided
        return context

    
    
class DocumentForm(MediaForm):
    class Meta:
        model = Document
        fields = '__all__'
        labels = {
            'title': 'Title',
            'description': 'Description',
            'file': 'Document File',
        }


class VideoForm(MediaForm):
    class Meta:
        model = Video
        fields = '__all__'
        labels = {
            'description': 'Description',
            'file': 'Video File',
            'poster': 'Video Poster (Image)',
        }


class IconForm(MediaForm):
    class Meta:
        model = Icon
        fields = '__all__'
        labels = {
            'name': 'Icon Name',
            'file': 'Icon File',
        }
        