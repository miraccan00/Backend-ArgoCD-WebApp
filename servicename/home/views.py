from django.shortcuts import render,redirect
from django.shortcuts import render
# from .models import 

def home(request):
    return render(request,'home/index.html')
