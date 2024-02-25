from django.http import FileResponse
from django.conf import settings
import os

def serve_webp(request, path):
    """
    Custom view to serve WebP files with the correct MIME type.
    """
    # Construct the absolute path to the requested WebP file
    file_path = os.path.join(settings.MEDIA_ROOT, path + '.webp')

    # Check if the file exists
    if os.path.exists(file_path):
        # Open the file for reading
        with open(file_path, 'rb') as f:
            # Create a FileResponse with the file content
            response = FileResponse(f)
            # Set the Content-Type header explicitly to 'image/webp'
            response['Content-Type'] = 'image/webp'
            # Return the response
            return response
    else:
        # Return a 404 Not Found response if the file does not exist
        #return HttpResponse(status=404)
        pass