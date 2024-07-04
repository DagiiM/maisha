from django.core.management.base import BaseCommand
from django.db import transaction
from django.apps import apps
from django.db.models.deletion import ProtectedError
import sys,json,os
from django.contrib.auth.models import User
from contact.models import Quote
from decouple import config
from about.models import SystemSettings

class Command(BaseCommand):
    help = 'Seeds the database with initial data'

    def add_arguments(self, parser):
        parser.add_argument(
            '--redo',
            action='store_true',
            help='Clear existing data and redo the seed process',
        )

    def handle(self, *args, **options):
        redo_seed = options['redo']
        with transaction.atomic():
            if redo_seed:
                confirm = input("WARNING: This action will delete all existing data in the specified models. Are you sure you want to proceed? (yes/no): ")
                if confirm.lower() != 'yes':
                    self.stdout.write(self.style.WARNING('Data seeding aborted'))
                    sys.exit(0)
                clear_data()  # Call the clear_data function to delete existing data

            seed_functions = [
               create_admin_users,
               create_quotes,
               seed_system_settings
            ]

            for seed_function in seed_functions:
                seed_function()

        self.stdout.write(self.style.SUCCESS('Data seeding completed'))


def clear_data():
    models_to_clear = [
        User,
        Quote
    ]

    with transaction.atomic():
        for model_info in models_to_clear:
            try:
                if isinstance(model_info, str):
                    model = apps.get_model(model_info)
                else:
                    model = model_info

                if model.objects.exists():
                    count = model.objects.count()
                    instances = model.objects.all()
                    for instance in instances:
                        try:
                            instance.delete()
                        except ProtectedError:
                            print(f"Cannot delete {instance} because it is referenced through protected foreign keys.")
            except (LookupError, AttributeError, ValueError) as e:
                print(f"Error while clearing data for model '{model_info}': {e}")
        
   
def create_admin_users():
    admins = [
        {'email': 'admin@eleso.ltd', 'first_name': 'Douglas', 'last_name': 'Mutethia', 'password': 'eleso.co.ke'},
        {'email': 'randie.marsh@handinhandkenya.org', 'first_name': 'Randie L.', 'last_name': 'Marsh', 'password': 'randie.marsh'},
    ]

    for admin in admins:
        email = admin['email']
        username = email.split('@')[0]  # Extract the username part before '@'
        password = admin['password']
        first_name = admin['first_name']
        last_name = admin['last_name']
        try:
            user, created = User.objects.get_or_create(email=email, username=username)
            if created:
                # Set additional attributes for new user
                user.first_name = first_name
                user.last_name = last_name
                user.is_staff = True  # Set is_staff to True for admin users
                user.is_superuser = True  # Set is_superuser to True for admin users
                user.set_password(password)
                user.save()
                print(f"Admin user '{email}' created successfully and set as staff.")
            else:
                print(f"Admin user '{email}' already exists.")
        except:
            pass


def create_quotes():
    file_path = f'{os.getcwd()}/quotes.json'
    try:
        with open(file_path, 'r') as file:
            quotes = json.load(file)
    except FileNotFoundError:
        print("quotes.json file not found.")
        return

    for quote_data in quotes:
        text = quote_data['text']
        context = quote_data.get('context', '')  # Optionally include context if available

        try:
            quote, created = Quote.objects.get_or_create(text=text, context=context)
            if created:
                print(f"Quote '{text}' created successfully.")
            else:
                print(f"Quote '{text}' already exists.")
        except Exception as e:
            print(f"An error occurred: {str(e)}")
            

def seed_system_settings():
    system_settings = {
        'site_title': config('APP_NAME', default='My Dashboard'),
        'primary_color': config('PRIMARY_COLOR', default='#007bff'),
        'secondary_color': config('SECONDARY_COLOR', default='#6c757d'),
        'email_from': config('EMAIL_HOST_USER', default='noreply@maishagirlssafehouse.org'),
        'email_host': config('EMAIL_HOST', default='smtp.gmail.com'),
        'email_port': config('EMAIL_PORT', cast=int, default=587),
        'email_username': config('EMAIL_HOST_USER', default='your_smtp_username'),
        'email_password': config('EMAIL_HOST_PASSWORD', default='your_smtp_password'),
        'enable_email_notifications': config('ENABLE_EMAIL_NOTIFICATIONS', cast=bool, default=True),
        'notification_email_recipients': config('NOTIFICATION_EMAIL_RECIPIENTS', default='admin@maishagirlssafehouse.org'),
        'use_original_images': config('USE_ORIGINAL_IMAGES', cast=bool, default=True),
        'image_quality': config('IMAGE_QUALITY', cast=int, default=80),
        'image_max_size': config('IMAGE_MAX_SIZE', cast=int, default=1024),
        'enable_caching': config('ENABLE_CACHING', cast=bool, default=True),
        'cache_timeout': config('CACHE_TIMEOUT', cast=int, default=3600),
        'cache_backend': config('CACHE_BACKEND', default='redis'),
        'log_level': config('LOG_LEVEL', default='INFO'),
        'log_file_path': config('LOG_FILE_PATH', default='/var/log/dashboard.log'),
        'log_file_size_limit': config('LOG_FILE_SIZE_LIMIT', cast=int, default=1048576),
        'enable_two_factor_auth': config('ENABLE_TWO_FACTOR_AUTH', cast=bool, default=False),
        'allowed_ip_ranges': config('ALLOWED_IP_RANGES', default='192.168.1.0/24,10.0.0.0/16'),
        'session_timeout': config('SESSION_TIMEOUT', cast=int, default=30),
        'data_retention_period': config('DATA_RETENTION_PERIOD', cast=int, default=30),
        'enable_data_archiving': config('ENABLE_DATA_ARCHIVING', cast=bool, default=True),
        'archive_storage_location': config('ARCHIVE_STORAGE_LOCATION', default='s3://my-dashboard-archive'),
        'maintenance_mode': config('MAINTENANCE_MODE', cast=bool, default=False)
    }

    try:
        with transaction.atomic():
            settings, created = SystemSettings.objects.get_or_create(id=1, defaults=system_settings)
            if created:
                print("System settings seeded successfully.")
            else:
                print("System settings already exist.")
    except Exception as e:
        print(f"An error occurred while seeding system settings: {str(e)}")