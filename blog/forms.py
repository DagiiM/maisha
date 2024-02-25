from django import forms
from .models import Blog
from ckeditor.widgets import CKEditorWidget

class BlogForm(forms.ModelForm):
    content = forms.CharField(widget=CKEditorWidget())
        
    class Meta:
        model = Blog
        fields = [
            'title',
            'slug',
            'content',
            'author',
            'categories',
            'tags',
            'featured',
            'image',
            'document',
            'video',
            'views',
            'likes',
        ]

        widgets = {
            'categories': forms.CheckboxSelectMultiple,
            'tags': forms.CheckboxSelectMultiple,
        }
