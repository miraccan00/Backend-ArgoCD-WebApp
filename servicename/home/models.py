from django.db import models

class Todo(models.Model):

    name=models.CharField(max_length=50)
    description=models.TextField()
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now=True)
    is_completed=models.BooleanField(default=False)
    is_deleted=models.BooleanField(default=False)

    def __str__(self):
        return self.name

