from django.contrib import admin
from .models import Partner,TeamMember
from app.admin import BaseAdmin

@admin.register(Partner)
class PartnerAdmin(BaseAdmin):
    list_display = ['company_name','contact_person','partnership_date','thumbnail','featured']
    
@admin.register(TeamMember)
class TeamAdmin(BaseAdmin):
    list_display = ['user','role','thumbnail','featured']