from django.contrib import admin
from app.admin import BaseAdmin
from .models import Event, Attendee

@admin.register(Event)
class EventAdmin(BaseAdmin):
    list_display = ('title', 'start_date', 'end_date','location','thumbnail')
    search_fields = ('title',)
    list_filter = ('start_date', 'end_date')
    

class EventInline(admin.TabularInline):
    list_display = ('name','email','phone_number','organization','event__title')