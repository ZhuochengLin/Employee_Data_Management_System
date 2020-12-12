from django.urls import path
from read import views

urlpatterns = [
    path('', views.read_employee),
    path('employee/', views.read_employee, name='read-employee'),
    path('emplpyee/<int:employee_id>/info', views.read_employee_info, name='read-employee-info'),
    path('employee/<int:employee_id>/salary', views.read_employee_salary, name='read-salary'),
    path('employee/<int:employee_id>/title', views.read_employee_title, name='read-title'),
    path('employee/<int:employee_id>/assignment', views.read_employee_assignment, name='read-assignment'),
    path('employee/all/', views.read_employee_all, name='read-all-employee'),
    path('department/', views.read_department, name='read-department'),
    path('sale/', views.read_sale_staff, name='read-sale-staff'),
    path('order/', views.read_order, name='read-order'),
    path('user/', views.read_user, name='read-user')

]
