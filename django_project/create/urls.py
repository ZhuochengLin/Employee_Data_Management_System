from django.urls import path
from . import views

urlpatterns = [
    path('', views.create_employee),
    path('employee/', views.create_employee, name='create-employee'),
    path('salary/', views.create_salary, name='create-salary'),
    path('title/', views.create_title, name='create-title'),
    path('department/', views.create_department, name='create-department'),
    path('assignment/', views.create_assignment, name='create-assignment'),
    path('order/', views.create_order, name='create-order'),
]