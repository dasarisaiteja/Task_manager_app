from django.db import models

class Task(models.Model):
    STATUS_CHOICES = [
        ('todo', 'To-Do'),
        ('in_progress', 'In Progress'),
        ('done', 'Done'),
    ]

    title = models.CharField(max_length=255)
    description = models.TextField()
    due_date = models.DateField()
    status = models.CharField(max_length=20, choices=STATUS_CHOICES)
    blocked_by = models.ForeignKey(
        'self', null=True, blank=True, on_delete=models.SET_NULL
    )

    def __str__(self):
        return self.title