# Generated by Django 4.2.5 on 2024-02-25 15:14

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('media', '0008_alter_document_object_id_alter_image_object_id_and_more'),
        ('contact', '0002_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='organization',
            name='video',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='media.video'),
        ),
    ]
