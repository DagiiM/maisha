# forms.py
from django import forms
from .models import Contact,OrganizationStep

class ContactForm(forms.ModelForm):
    class Meta:
        model = Contact
        fields = ['name', 'email', 'message', 'subscribed']

    def clean_email(self):
        email = self.cleaned_data['email']
        if Contact.objects.filter(email=email).exists():
            raise forms.ValidationError("This email address is already subscribed.")
        return email

class OrganizationStepForm(forms.ModelForm):
    class Meta:
        model = OrganizationStep
        fields = '__all__'
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)