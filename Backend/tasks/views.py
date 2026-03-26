from rest_framework import viewsets
from .models import Task
from .serializers import TaskSerializer
import time

class TaskViewSet(viewsets.ModelViewSet):
    queryset = Task.objects.all().order_by('-id')
    serializer_class = TaskSerializer

    def create(self, request, *args, **kwargs):
        time.sleep(2)
        return super().create(request, *args, **kwargs)

    def update(self, request, *args, **kwargs):
        time.sleep(2)
        return super().update(request, *args, **kwargs)