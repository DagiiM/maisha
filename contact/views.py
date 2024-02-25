# views.py
from django.shortcuts import render, redirect
from rest_framework import generics
from .models import Contact
from .forms import ContactForm
from .serializers import ContactSerializer
from .serializers import OrganizationSerializer, QuoteSerializer
from app.views import BaseViewSet
from .serializers import OrganizationStepSerializer
import uuid
from django.db import IntegrityError

class OrganizationStepViewSet(BaseViewSet):
    serializer_class = OrganizationStepSerializer
    
    def get_queryset(self):
        return super().get_queryset().order_by('next_step')


def subscribe(request):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            # Check if email already exists
            if Contact.objects.filter(email=email).exists():
                return redirect('thank_you_page', unique_url=email)
            else:
                try:
                    form.save()
                    # Redirect to thank you page with email as parameter
                    return redirect('thank_you_page', unique_url=email)
                except IntegrityError as e:
                    return redirect('thank_you_page', unique_url=email)
    else:
        form = ContactForm()

    return render(request, 'contact.html', {'form': form})

def thank_you_page(request, unique_url):
    if validate_subscription_token(unique_url):
        return render(request, 'thank_you_page.html', {'email': unique_url})
    else:
        return redirect('error_page')
    
def validate_subscription_token(token):
    # Check if the token exists in the database
    try:
        token_obj = Contact.objects.get(email=token)
        # If the token exists, return True
        return True
    except Contact.DoesNotExist:
        # If the token does not exist, return False
        return False


def error_page(request):
    return render(request, 'error_page.html')

class ContactViewSet(BaseViewSet):
    serializer_class = ContactSerializer


class OrganizationViewSet(BaseViewSet):
    serializer_class = OrganizationSerializer
    

class QuoteViewSet(BaseViewSet):
    serializer_class = QuoteSerializer
    
    def get_queryset(self):
        queryset = super().get_queryset()
        return queryset.order_by('?')[:20]
    
