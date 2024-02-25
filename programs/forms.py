from .models import Program
from django import forms
class ProgramForm(forms.ModelForm):
    class Meta:
        model = Program
        fields = ['title', 'description', 'start_date', 'end_date', 'impact_overview']
