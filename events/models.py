from django.db import models
from app.models import BaseModel
from django.utils import timezone
from media.models import Image
from django.core.exceptions import ValidationError


class Attendee(BaseModel):
    name = models.CharField(max_length=200)
    email = models.EmailField()
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    organization = models.CharField(max_length=200, blank=True, null=True)

    def __str__(self):
        return self.name
    
    
class Event(BaseModel):
    title = models.CharField(max_length=200)
    description = models.TextField()
    image = models.ForeignKey(Image, on_delete=models.PROTECT,help_text="Event Image")
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    location = models.CharField(max_length=200, blank=True, null=True)
    attendees = models.ManyToManyField(Attendee, related_name='events', blank=True)

    def __str__(self):
        return self.title
    
    def is_ongoing(self):
        now = timezone.now()
        return self.start_date <= now <= self.end_date
    
    def clean(self):
        if self.start_date >= self.end_date:
            raise ValidationError('Start date must be before end date.')
        
        