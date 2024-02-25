from django.contrib import admin
from app.admin import BaseAdmin
from .models import Program, Activity

@admin.register(Program)
class ProgramAdmin(BaseAdmin):
    list_display = ('title', 'start_date', 'end_date')
    search_fields = ('title',)
    list_filter = ('start_date', 'end_date')

@admin.register(Activity)
class ActivityAdmin(BaseAdmin):
    list_display = ('title', 'program', 'image')
    search_fields = ('title', 'program__title')
    list_filter = ('program',)

