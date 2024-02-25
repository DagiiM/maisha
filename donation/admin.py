from django.contrib import admin
from .models import Donor, Donation
from app.admin import BaseAdmin

@admin.register(Donation)
class DonationAdmin(BaseAdmin):
    list_display = ('donor', 'program', 'amount','donation_date')
    
@admin.register(Donor)
class DonorAdmin(BaseAdmin):
    list_display = ('user', 'phone_number', 'registration_date')

