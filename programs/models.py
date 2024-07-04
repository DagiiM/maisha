from django.db import models
from app.models import BaseModel
from media.models import Image,Icon

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
    description = models.TextField(help_text="Activity Description")
    program = models.ForeignKey(Program, on_delete=models.PROTECT,related_name='activities')
    image = models.ForeignKey(Image, on_delete=models.PROTECT,help_text="Activity Image")
    
    class Meta:
        verbose_name = "Activity"
        verbose_name_plural = "Activities"  
        
    def __str__(self):
        return self.title
    
class Service(BaseModel):
    title = models.CharField(max_length=200)
    description = models.TextField()
    image = models.ForeignKey(Image, on_delete=models.PROTECT,help_text="Service Image",null=True,blank=True)
    icon = models.ForeignKey(Icon, on_delete=models.PROTECT,help_text="Service Icon",null=True,blank=True)
        
    def __str__(self):
        return self.title