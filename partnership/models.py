from django.db import models
from app.models import BaseModel
from media.models import Image
from contact.models import Address,ContactInformation
from django.contrib.auth.models import User

class Partner(BaseModel):
    company_name = models.CharField(max_length=100)
    contact_person = models.CharField(max_length=100)
    partnership_date = models.DateField(auto_now_add=True)
    logo = models.OneToOneField(Image, on_delete=models.CASCADE, null=True, blank=True)  # Borrowed logo field
    address = models.OneToOneField(Address, on_delete=models.CASCADE)  # Borrowed address field
    contact_info = models.OneToOneField(ContactInformation, on_delete=models.CASCADE)  # Borrowed contact_info field

    def __str__(self):
        return f"Partner: {self.company_name}"
    
class TeamMember(BaseModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    role = models.CharField(max_length=100)
    bio = models.CharField(max_length=100)
    image = models.OneToOneField(Image, on_delete=models.CASCADE, null=True, blank=True)
    contact_info = models.OneToOneField(ContactInformation, on_delete=models.CASCADE)  # Borrowed contact_info field

    def __str__(self):
        return f"member: {self.user.first_name}"