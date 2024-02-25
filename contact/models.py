from django.db import models
from media.models import Image,Video
from app.models import BaseModel
 
class Contact(BaseModel):
    name = models.CharField(max_length=100, verbose_name="Full Name")
    email = models.EmailField(verbose_name="Email Address", unique=True)
    message = models.TextField(default="", verbose_name="Message")
    subscribed = models.BooleanField(default=False, verbose_name="Subscribed to Newsletter")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Created At")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Updated At")

    class Meta:
        verbose_name = "Contact"
        verbose_name_plural = "Contacts"

    def __str__(self):
        return self.name

class Address(BaseModel):
    street = models.CharField(max_length=100)
    city = models.CharField(max_length=50)
    state = models.CharField(max_length=50)
    postal_code = models.CharField(max_length=10)

    def delete(self, using=None, keep_parents=False):
        """
        Override the delete method in Address to call BaseModel's delete method.
        """
        super().delete(using=using, keep_parents=keep_parents)
        
class ContactInformation(BaseModel):
    phone = models.CharField(max_length=15)
    email = models.EmailField()
    website = models.URLField()

class Organization(BaseModel):
    name = models.CharField(max_length=100)
    description = models.TextField()
    mission = models.TextField()
    vision = models.TextField()
    values = models.TextField()
    address = models.OneToOneField(Address, on_delete=models.CASCADE)
    contact_info = models.OneToOneField(ContactInformation, on_delete=models.CASCADE)
    logo = models.OneToOneField(Image, on_delete=models.CASCADE, null=True, blank=True)
    video = models.ForeignKey(Video,on_delete=models.SET_NULL,null=True,blank=True)
    
    def save(self, *args, **kwargs):
        # Ensure there's only one instance of this model
        if not self.pk and Organization.objects.exists():
            return
        super(Organization, self).save(*args, **kwargs)

    def delete(self, *args, **kwargs):
        # Prevent deletion of the single instance
        pass


class OrganizationStep(BaseModel):
    title = models.CharField(max_length=255)
    description = models.TextField()
    next_step = models.OneToOneField('OrganizationStep', on_delete=models.SET_NULL, null=True, blank=True, related_name='prev_step')

    def __str__(self):
        return self.title
    
class Subscription(BaseModel):
    contact = models.ForeignKey(Contact, on_delete=models.CASCADE)
    newsletter_name = models.CharField(max_length=100)

    class Meta:
        verbose_name = "Subscription"
        verbose_name_plural = "Subscriptions"


class Quote(BaseModel):
    text = models.TextField()
    context = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.text


