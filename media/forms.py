from django import forms
from .models import Image, Document, Video, Media
from .validator import MediaField

class MediaForm(forms.ModelForm):
    class Meta:
        model = Media
        fields = '__all__'
'''
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Dynamically set the choices for the object_id field based on the selected content_type
        content_type = self.instance.content_type if self.instance.pk else None
        if content_type:
            model_class = content_type.model_class()
            if model_class:
                # Fetch all instances of the related model and create choices from their primary keys
                object_choices = [(obj.pk, str(obj)) for obj in model_class.objects.all()]
                # Update the widget for object_id to a Select widget with the choices
                self.fields['object_id'].widget = forms.Select(choices=object_choices)
            else:
                # If model_class is None, clear the choices for object_id
                self.fields['object_id'].widget = forms.Select(choices=[])
        else:
            # If content_type is None, clear the choices for object_id
            self.fields['object_id'].widget = forms.Select(choices=[])
       '''       
class ImageForm(MediaForm):
    file = MediaField()

    class Meta:
        model = Image
        fields = '__all__'
        labels = {
            'caption': 'Caption',
            'featured': 'Featured',
            'file': 'Image File',
        }

class DocumentForm(MediaForm):
    file = MediaField()

    class Meta:
        model = Document
        fields = '__all__'
        labels = {
            'title': 'Title',
            'description': 'Description',
            'file': 'Document File',
        }


class VideoForm(MediaForm):
    file = MediaField()

    class Meta:
        model = Video
        fields = '__all__'
        labels = {
            'description': 'Description',
            'file': 'Video File',
            'poster': 'Video Poster (Image)',
        }



 