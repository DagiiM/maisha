from django.db import models
from app.models import BaseModel
from media.models import Image
from contact.models import Address,ContactInformation
from django.contrib.auth.models import User

class Partner(BaseModel):
    company_name = models.CharField(max_length=100, verbose_name="Company Name")
    contact_person = models.CharField(max_length=100, verbose_name="Contact Person")
    partnership_date = models.DateField(auto_now_add=True, verbose_name="Partnership Date")
    image = models.OneToOneField(Image, on_delete=models.PROTECT, null=True, blank=True, help_text="Partner Logo")
    address = models.OneToOneField(Address, on_delete=models.PROTECT, null=True, blank=True)
    contact_info = models.OneToOneField(ContactInformation, on_delete=models.PROTECT)
    featured = models.BooleanField(default=False, verbose_name="Featured", help_text="Mark this partner as featured")

    def __str__(self):
        return f"Partner: {self.company_name}"


class TeamMember(BaseModel):
    user = models.ForeignKey(User, on_delete=models.PROTECT)
    role = models.CharField(max_length=100, verbose_name="Role")
    bio = models.CharField(max_length=100, verbose_name="Bio")
    image = models.OneToOneField(Image, on_delete=models.PROTECT, null=True, blank=True)
    contact_info = models.OneToOneField(ContactInformation, on_delete=models.PROTECT, null=True, blank=True)
    featured = models.BooleanField(default=False, verbose_name="Featured", help_text="Mark this team member as featured")

    def __str__(self):
        return f"member: {self.user.username}"