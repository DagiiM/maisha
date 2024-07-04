# media/settings.py

IMAGE_VERSIONS = {
    'thumbnail': {
        'width': 250,
        'resize_mode': 'LANCZOS',
        'quality': 95,
    },
    'medium': {
        'width': 460,
        'resize_mode': 'LANCZOS',
        'quality': 95,
    },
    'large': {
        'width': 800,
        'resize_mode': 'LANCZOS',
        'quality': 95,
    },
    'social': {
        'width': 1080,
        'resize_mode': 'LANCZOS',
        'quality': 95,
    },
}

IMAGE_ASPECT_RATIO = 3 / 4
IMAGE_RESIZE_MODE = 'LANCZOS'