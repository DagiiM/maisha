# admin.py
from django.contrib import admin
from .models import Contact
from django.contrib import admin
from .models import Organization,Address,ContactInformation
from app.admin import BaseAdmin
from .models import OrganizationStep
from .forms import OrganizationStepForm

@admin.register(OrganizationStep)
class OrganizationStepAdmin(BaseAdmin):
    form = OrganizationStepForm
    list_display = ('title', 'description', 'next_step')
    search_fields = ['title', 'description']

@admin.register(Organization)
class OrganizationAdmin(BaseAdmin):
    # Disable the "Add" button in the admin to prevent creating additional instances
    def has_add_permission(self, request):
        return not Organization.objects.exists()

    # Customize the display of the single instance
    list_display = ('name', 'description', 'mission', 'vision', 'values')

    # You can add more customizations as needed


@admin.register(Contact)
class ContactAdmin(BaseAdmin):
    list_display = ('name', 'email', 'subscribed')
    

@admin.register(Address)
class AddressAdmin(BaseAdmin):
    list_display = ('street', 'city', 'state', 'postal_code', 'soft_deleted')


@admin.register(ContactInformation)
class ContactInformationAdmin(BaseAdmin):
    pass  # You can customize the ContactInformation admin if needed


