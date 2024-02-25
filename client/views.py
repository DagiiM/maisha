from django.shortcuts import render, redirect
from django.urls import reverse
from django.conf import settings
from django.shortcuts import render

def about(request):
    return render(request,'about.html')

def welcome(request):
    return render(request,'welcome.html')

def ways_to_support(request):
    return render(request,'ways_to_support.html')

def why_maisha(request):
    return render(request,'why_maisha.html')

def contact(request):
    return render(request,'contact.html')

def program(request, program_id=None):  # Make program_id optional by setting it to None
    if program_id is not None:
        # Your logic to retrieve program details using program_id
        # Example: program = Program.objects.get(pk=program_id)
        return render(request, 'program.html', {'program_id': program_id})
    else:
        # Handle the case when no program_id is provided
        # You can render a different template or redirect to another page
        return render(request, 'program.html')

def blog(request):
    return render(request,'blog.html')

def completed(request):
    return render(request,'donations/completed.html')

def canceled(request):
    return render(request,'donations/cancelled.html')
