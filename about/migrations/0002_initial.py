# Generated by Django 4.2.5 on 2024-04-08 17:10

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('about', '0001_initial'),
        ('media', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='about',
            name='image',
            field=models.ForeignKey(blank=True, help_text='Image related', null=True, on_delete=django.db.models.deletion.CASCADE, to='media.image'),
        ),
    ]