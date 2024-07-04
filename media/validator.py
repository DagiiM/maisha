
from django.utils.translation import gettext_lazy as _
import os
    
def custom_upload_path(instance, filename):
    """
    Constructs the upload path for media files.
    """
    model_name = instance.__class__.__name__.lower()
    if model_name in ['document', 'icon', 'video', 'image']:
        return os.path.join('uploads', f'{model_name}s', filename)
    else:
        return os.path.join('custom', model_name, filename)