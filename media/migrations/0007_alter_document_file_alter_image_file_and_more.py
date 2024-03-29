# Generated by Django 4.2.5 on 2024-02-25 11:40

from django.db import migrations, models
import media.validator


class Migration(migrations.Migration):

    dependencies = [
        ('media', '0006_rename_image_versions_image_versions'),
    ]

    operations = [
        migrations.AlterField(
            model_name='document',
            name='file',
            field=models.FileField(blank=True, null=True, upload_to=media.validator.custom_upload_path),
        ),
        migrations.AlterField(
            model_name='image',
            name='file',
            field=models.FileField(blank=True, null=True, upload_to=media.validator.custom_upload_path),
        ),
        migrations.AlterField(
            model_name='video',
            name='file',
            field=models.FileField(blank=True, null=True, upload_to=media.validator.custom_upload_path),
        ),
    ]
