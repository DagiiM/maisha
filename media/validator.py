from django.core.exceptions import ValidationError
from django.db.models import FileField
from django.utils.translation import gettext_lazy as _
from PIL import Image
import mimetypes
import os

class MediaField(FileField):
    IMAGE_EXTENSIONS = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.tiff', '.tif']
    DOCUMENT_EXTENSIONS = ['.pdf', '.doc', '.docx', '.txt']
    VIDEO_EXTENSIONS = ['.mp4', '.avi', '.mov', '.wmv']
    AUDIO_EXTENSIONS = ['.mp3', '.wav', '.wma']

    ALLOWED_TYPES = [
        'image/jpeg', 'image/png', 'image/gif',  # Images
        'application/pdf',  # PDF
        'text/plain', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',  # Documents
        'video/mp4', 'video/x-msvideo', 'video/x-ms-wmv', 'video/quicktime',  # Videos
        'audio/mpeg', 'audio/x-wav', 'audio/x-ms-wma',  # Audio
    ]

    COMMON_MEDIA_EXTENSIONS = (
        IMAGE_EXTENSIONS +
        DOCUMENT_EXTENSIONS +
        VIDEO_EXTENSIONS +
        AUDIO_EXTENSIONS
    )

    RESIZE_DIMENSIONS = (480, 640)

    def __init__(self, *args, **kwargs):
        self.allow_resizing = kwargs.pop('allow_resizing', False)
        super().__init__(*args, **kwargs)

    def validate_file_type(self, value):
        _, file_extension = os.path.splitext(value.name.lower())

        try:
            # Check if value.file is not None before accessing content_type
            if value.file is not None and hasattr(value.file, 'content_type'):
                content_type = value.file.content_type
            else:
                # If 'content_type' attribute is not present, try to determine it using mimetypes
                content_type, _ = mimetypes.guess_type(value.name)

            if content_type not in self.ALLOWED_TYPES and file_extension not in self.COMMON_MEDIA_EXTENSIONS:
                raise ValidationError(_('Invalid file type. Allowed types: image, document, video, audio.'))
        except Exception as e:
            # Handle any other exceptions that might occur
            raise ValidationError(_('Error validating file type. Please try again.'))

    def resize_image(self, value):
        try:
            img = Image.open(value)
            img = img.resize(self.RESIZE_DIMENSIONS, Image.ANTIALIAS)

            with self.storage.open(value.name, 'wb') as f:
                img.save(f, format=img.format)
        except Exception as e:
            raise ValidationError(_('Error resizing image. Please try again.'))

    def clean(self, *args, **kwargs):
        data = super().clean(*args, **kwargs)
        self.validate_file_type(data)

        _, file_extension = os.path.splitext(data.name.lower())

        # Check if resizing is allowed for the specific model and if the file is an image
        if self.allow_resizing and file_extension in self.IMAGE_EXTENSIONS:
            self.resize_image(data)

        return data

    def generate_filename(self, instance, filename):
        model_name = instance.__class__.__name__.lower()

        if model_name in ['document', 'video', 'image']:
            return f'uploads/{model_name}s/{filename}'
        else:
            return f'custom/{model_name}/{filename}'

    def get_upload_to(self, instance, filename):
        return self.generate_filename(instance, filename)


class ResizableMediaField(FileField):
    ALLOWED_TYPES = [
        'image/jpeg', 'image/png', 'image/gif',
    ]

    IMAGE_EXTENSIONS = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.tiff', '.tif']

    RESIZE_DIMENSIONS = (480, 640)

    def __init__(self, *args, **kwargs):
        self.allow_resizing = kwargs.pop('allow_resizing', False)
        super().__init__(*args, **kwargs)

    def validate_file_type(self, value):
        _, file_extension = os.path.splitext(value.name.lower())

        try:
            # Check if value.file is not None before accessing content_type
            if value.file is not None and hasattr(value.file, 'content_type'):
                content_type = value.file.content_type
            else:
                # If 'content_type' attribute is not present, try to determine it using mimetypes
                content_type, _ = mimetypes.guess_type(value.name)

            if content_type not in self.ALLOWED_TYPES or file_extension not in self.IMAGE_EXTENSIONS:
                raise ValidationError(_('Invalid file type. Allowed types: JPEG, PNG, GIF.'))
        except Exception as e:
            # Handle any other exceptions that might occur
            raise ValidationError(_('Error validating file type. Please try again.'))

    def resize_image(self, value):
        try:
            img = Image.open(value)
            img = img.resize(self.RESIZE_DIMENSIONS, Image.ANTIALIAS)

            with self.storage.open(value.name, 'wb') as f:
                img.save(f, format=img.format)
        except Exception as e:
            raise ValidationError(_('Error resizing image. Please try again.'))

    def clean(self, *args, **kwargs):
        data = super().clean(*args, **kwargs)
        self.validate_file_type(data)

        # If resizing is allowed and the file is an image, perform resizing
        _, file_extension = os.path.splitext(data.name.lower())
        if self.allow_resizing and file_extension in self.IMAGE_EXTENSIONS:
            self.resize_image(data)

        return data

    def generate_filename(self, instance, filename):
        model_name = instance.__class__.__name__.lower()
        return f'uploads/{model_name}s/{filename}'

    def get_upload_to(self, instance, filename):
        return self.generate_filename(instance, filename)
    
    
def custom_upload_path(instance, filename):
    model_name = instance.__class__.__name__.lower()

    if model_name == 'document':
        return f'uploads/{model_name}s/{filename}'
    elif model_name == 'video':
        return f'uploads/{model_name}s/{filename}'
    elif model_name == 'image':
        return f'uploads/{model_name}s/{filename}'
    else:
        return f'custom/{model_name}/{filename}'