# Generated by Django 4.2.5 on 2024-05-01 07:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('media', '0005_delete_duplicateimage'),
    ]

    operations = [
        migrations.CreateModel(
            name='DuplicateImageCluster',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('images', models.ManyToManyField(related_name='clusters', to='media.image')),
            ],
        ),
    ]