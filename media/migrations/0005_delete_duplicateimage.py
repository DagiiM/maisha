# Generated by Django 4.2.5 on 2024-04-28 19:06

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('media', '0004_alter_document_object_id_alter_icon_object_id_and_more'),
    ]

    operations = [
        migrations.DeleteModel(
            name='DuplicateImage',
        ),
    ]