# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Sprint(models.Model):
    name = models.CharField(max_length=50)
    goal = models.TextField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    status = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'sprint'

    @property
    def label(self):
        # Texto p/ botões
        return f"{self.start_date.strftime('%d/%m/%Y')} - {self.end_date.strftime('%d/%m/%Y')}"

    def __str__(self):
        return self.label


class Squad(models.Model):
    name = models.CharField(max_length=45)
    description = models.TextField(blank=True, null=True)
    mission = models.TextField()
    contact_channel = models.CharField(blank=True, null=True, max_length=100)
    created_at = models.DateTimeField()
    is_active = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'squad'

    def __str__(self):
        return self.name

class SquadMember(models.Model):
    name = models.CharField(max_length=100)
    role = models.CharField(max_length=50)
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=20)
    city = models.CharField(max_length=100)
    created_at = models.DateTimeField()
    squad = models.ForeignKey(Squad, on_delete=models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'squad_member'

    def __str__(self):
        return self.name


class Task(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    priority = models.CharField(max_length=20)
    created_at = models.DateTimeField()
    deadline = models.DateTimeField()
    completed_at = models.DateTimeField(blank=True, null=True)
    squad = models.ForeignKey(Squad, on_delete=models.DO_NOTHING)
    sprint = models.ForeignKey(Sprint, on_delete=models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'task'

    def __str__(self):
        return self.title


class TaskImage(models.Model):
    url = models.CharField(max_length=255)
    caption = models.CharField(max_length=150)
    uploaded_at = models.DateTimeField()
    task = models.ForeignKey(Task, on_delete=models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'task_image'
