from django.core.management.base import BaseCommand
from django.db import transaction
from django.apps import apps
from django.db.models.deletion import ProtectedError
import sys,json,os
from django.contrib.auth.models import User
from contact.models import Quote

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
               create_quotes
            ]

            for seed_function in seed_functions:
                seed_function()

        self.stdout.write(self.style.SUCCESS('Data seeding completed'))


def clear_data():
    models_to_clear = [
        #'claims.ClaimType',
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