from django.contrib.auth.models import User
from django.db import models
from app.models import BaseModel
from programs.models import Program

class Donor(BaseModel):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='donor')
    phone_number = models.CharField(max_length=15)
    address = models.TextField()
    registration_date = models.DateField(auto_now_add=True)

    def total_donations(self):
        return self.donations.aggregate(total=models.Sum('amount'))['total'] or 0

    def num_donations(self):
        return self.donations.count()

    def avg_donation_amount(self):
        return self.donations.aggregate(average=models.Avg('amount'))['average'] or 0

    def __str__(self):
        return f"Donor: {self.user.first_name} {self.user.last_name}"


class Donation(BaseModel):
    donor = models.ForeignKey(Donor, on_delete=models.CASCADE, related_name='donations')
    program = models.ForeignKey(Program, on_delete=models.CASCADE, related_name='donations')
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    donation_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Donation by {self.donor.user.first_name} to {self.project.title}"
