# Generated by Django 4.2.5 on 2024-05-01 08:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('media', '0006_duplicateimagecluster'),
    ]

    operations = [
        migrations.AddField(
            model_name='duplicateimagecluster',
            name='updated_at',
            field=models.DateTimeField(auto_now=True),
        ),
    ]