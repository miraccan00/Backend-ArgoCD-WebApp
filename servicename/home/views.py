from django.shortcuts import render,redirect
from django.shortcuts import render
from .models import Todo 

def home(request):
    
    todos=Todo.objects.all()
    
    context={'todos':todos}
    return render(request,'home/index.html',context)