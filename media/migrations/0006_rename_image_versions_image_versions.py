# Generated by Django 4.2.5 on 2024-02-23 15:06

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('media', '0005_rename_versions_image_image_versions'),
    ]

    operations = [
        migrations.RenameField(
            model_name='image',
            old_name='image_versions',
            new_name='versions',
        ),
    ]