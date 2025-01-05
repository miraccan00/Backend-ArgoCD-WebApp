from django.shortcuts import render,redirect
from django.shortcuts import render
# from .models import 

def home(request):
    return render(request,'home/index.html')

def home2(request):
    return render(request,'home2/index.html')

def home3(request):
    return render(request,'home2/index.html')
