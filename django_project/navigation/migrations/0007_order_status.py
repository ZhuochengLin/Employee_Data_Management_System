# Generated by Django 3.1.3 on 2020-12-10 00:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('navigation', '0006_order_salestaff'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='status',
            field=models.CharField(choices=[('F', 'Finished'), ('A', 'Active')], default='A', max_length=10),
        ),
    ]
