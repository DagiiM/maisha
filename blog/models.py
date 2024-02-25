from django.db import models
from django.contrib.auth.models import User
from django.urls import reverse
from django.utils.text import slugify
from media.models import Image, Document, Video
from app.models import BaseModel

class Category(BaseModel):
    name = models.CharField(max_length=100)
    slug = models.SlugField(unique=True)
    description = models.TextField(blank=True)
    
    search_fields = ['name','description']
    fields_to_return = ['name','description']

    def __str__(self):
        return self.name

class Tag(BaseModel):
    name = models.CharField(max_length=50)
    slug = models.SlugField(unique=True)
    description = models.TextField(blank=True)
    
    search_fields = ['name','description']
    fields_to_return = ['name','description']
    
    
    def __str__(self):
        return self.name

class Blog(BaseModel):
    title = models.CharField(max_length=200)
    slug = models.SlugField(unique=True)
    content = models.TextField()
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    categories = models.ManyToManyField(Category)
    tags = models.ManyToManyField(Tag)
    publication_date = models.DateTimeField(auto_now_add=True)
    last_modified = models.DateTimeField(auto_now=True)
    featured = models.BooleanField(default=False)
    image = models.ForeignKey(Image, on_delete=models.SET_NULL, null=True, blank=True)
    document = models.ForeignKey(Document,on_delete=models.SET_NULL,null=True,blank=True)
    video = models.ForeignKey(Video,on_delete=models.SET_NULL,null=True,blank=True)
    views = models.PositiveIntegerField(default=0)
    likes = models.PositiveIntegerField(default=0)
    
    # Specify search_fields for searching
    search_fields = ['title', 'content', 'tags__name', 'categories__name']
    # Specify fields_to_return for serialization
    fields_to_return = ['title', 'publication_date', 'author', 'categories', 'tags']


    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('blog:post_detail', args=[str(self.slug)])


class Subscription(BaseModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    subscribed_categories = models.ManyToManyField(Category)
    subscribed_tags = models.ManyToManyField(Tag)

    def __str__(self):
        return f"Subscriptions for {self.user.username}"
