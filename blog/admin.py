from django.contrib import admin
from .models import Category, Tag, Blog, Subscription
from .forms import BlogForm
from app.admin import BaseAdmin


class CategoryAdmin(BaseAdmin):
    prepopulated_fields = {'slug': ('name',)}

class TagAdmin(BaseAdmin):
    prepopulated_fields = {'slug': ('name',)}

class BlogAdmin(BaseAdmin):
    form = BlogForm
    
    prepopulated_fields = {'slug': ('title',)}

class SubscriptionAdmin(BaseAdmin):
    pass  

# Register your models with the admin site
admin.site.register(Category, CategoryAdmin)
admin.site.register(Tag, TagAdmin)
admin.site.register(Blog, BlogAdmin)
admin.site.register(Subscription, SubscriptionAdmin)
