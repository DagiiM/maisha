# serializers.py
from rest_framework import serializers
from .models import Contact,Organization, Address, ContactInformation, Quote
from app.serializers import BaseSerializer
from media.serializers import ImageSerializer,VideoSerializer
from rest_framework import serializers
from .models import OrganizationStep


class OrganizationStepSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrganizationStep
        fields = '__all__'


class QuoteSerializer(BaseSerializer):
    class Meta:          
        model = Quote
        fields = ['id', 'text', 'context']

class ContactSerializer(BaseSerializer):
    class Meta:
        model = Contact
        fields = '__all__'

class AddressSerializer(BaseSerializer):
    class Meta:
        model = Address
        fields = ['street', 'city', 'state','postal_code']

class ContactInformationSerializer(BaseSerializer):
    class Meta:
        model = ContactInformation
        fields = ['phone','email','website']

class OrganizationSerializer(BaseSerializer):
    address = AddressSerializer()
    contact_info = ContactInformationSerializer()
    logo = ImageSerializer()
    video = VideoSerializer()

    class Meta:
        model = Organization
        fields = '__all__'

