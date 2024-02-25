from django.db import models
from app.models import BaseModel
from media.models import Image

class Program(BaseModel):
    title = models.CharField(max_length=200)
    description = models.TextField()
    start_date = models.DateField()
    end_date = models.DateField()
    impact_overview = models.TextField()

    def __str__(self):
        return self.title
    
class Activity(BaseModel):
    title = models.CharField(max_length=200)
    description = models.TextField()
    program = models.ForeignKey(Program, on_delete=models.CASCADE,related_name='activities')
    image = models.ForeignKey(Image, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.title