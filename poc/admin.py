from django.contrib import admin

# Register your models here.

from django.contrib import admin
from .models import Sprint, Squad, SquadMember, Task, TaskImage

admin.site.register(Sprint)
admin.site.register(Squad)
admin.site.register(SquadMember)
admin.site.register(Task)
admin.site.register(TaskImage)