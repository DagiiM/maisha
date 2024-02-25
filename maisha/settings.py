import os
from pathlib import Path
from decouple import config

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = config('SECRET_KEY')

PAYPAL_MODE = config('PAYPAL_MODE')  # sandbox or live
PAYPAL_CLIENT_ID = config('PAYPAL_CLIENT_ID')
PAYPAL_CLIENT_SECRET = config('PAYPAL_CLIENT_SECRET')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['*']


# Application definition

INSTALLED_APPS = [
    'app.apps.MyAdminConfig',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'about',
    'client',
    'ckeditor',
    'ckeditor_uploader',
    'media',
    'partnership',
    'blog',
    'comments',
    'search',
    'trash',
    'rest_framework',
    'mpesa',
    'contact',
    'programs',
    'sslserver'
]

# Configure SSL settings
SSL_ENABLED = False
SSL_CERTIFICATE = 'localhost.crt'
SSL_KEY = 'localhost.key'

MPESA_CONFIG = {
    'CONSUMER_KEY': 'yIqAbNZV3tOaGFz22IqwLSkcCDyzNAZa',
    'CONSUMER_SECRET': 'trG0bSNuroErKB2Y',
    'CERTIFICATE_FILE': None,
    'HOST_NAME': 'https://7220-197-179-245-152.ngrok-free.app/mpesa/submit/',
    'PASS_KEY': 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
    'SAFARICOM_API': 'https://sandbox.safaricom.co.ke',
    'AUTH_URL': '/oauth/v1/generate?grant_type=client_credentials',
    'SHORT_CODE': '174379',
    'TILL_NUMBER': None,
    'TRANSACTION_TYPE': 'CustomerBuyGoodsOnline',
}

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.gzip.GZipMiddleware',
]

ROOT_URLCONF = 'maisha.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': ['templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'maisha.wsgi.application'

PAGE_SIZE =config('PAGE_SIZE')
MAX_PAGE_SIZE = config('MAX_PAGE_SIZE')

CACHE_TTL = config('CACHE_TTL', default=300, cast=int)

# Redis configuration
REDIS_HOST = config('REDIS_HOST', default='127.0.0.1')
REDIS_PORT = config('REDIS_PORT', default=6379, cast=int)
REDIS_DB = config('REDIS_DB', default=0, cast=int)

CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_DB}",
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        }
    }
}

# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': f"django.db.backends.{config('DATABASE_ENGINE') or 'sqlite3'}",
        'NAME': config('DATABASE_NAME') or BASE_DIR / 'db.sqlite3',
        'USER': config('DATABASE_USER'),
        'PASSWORD': config('DATABASE_PASSWORD'),
        'HOST': config('DATABASE_HOST','localhost'),
        'PORT': config('DATABASE_PORT',3306),
    }
}


# Password validation
# https://docs.djangoproject.com/en/4.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.2/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = config('TIME_ZONE','Africa/Nairobi')

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.2/howto/static-files/

STATIC_URL = 'static/'
STATIC_ROOT = BASE_DIR /'static'
STATICFILES_DIRS = [
    'app/static',
]

# Default primary key field type
# https://docs.djangoproject.com/en/4.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'


MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')


APP_DOMAIN = config('APP_DOMAIN','eleso.ltd') 
APP_NAME = config('APP_NAME','Eleso Ltd')
APP_TAGLINE = config('APP_TAGLINE')

LOGIN_REDIRECT_URL = '/'
LOGIN_URL = 'login'
LOGOUT_URL = 'logout'


EMAIL_HOST = config('EMAIL_HOST')
EMAIL_HOST_USER = config('EMAIL_HOST_USER')
EMAIL_HOST_PASSWORD = config('EMAIL_HOST_PASSWORD')
EMAIL_PORT = config('EMAIL_PORT',587)
EMAIL_USE_TLS = config('EMAIL_USE_TLS', True)
#EMAIL_USE_SSL = config('EMAIL_USE_SSL',False)
EMAIL_SUBJECT_PREFIX = config('EMAIL_SUBJECT_PREFIX')
EMAIL_USE_REMEMBER_ME = config('EMAIL_USE_REMEMBER_ME', True)
EMAIL_SUPPORT = config('EMAIL_SUPPORT')


CKEDITOR_UPLOAD_PATH = "uploads/"
CKEDITOR_IMAGE_BACKEND = "pillow"
CKEDITOR_JQUERY_URL = '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js'
CKEDITOR_CONFIGS = {
    'default': {
        'toolbar': 'full',
        'height': 300,
        'extraPlugins': 'codesnippet',
        'skin': 'office2013',
        'width': '100%',
    },
}
