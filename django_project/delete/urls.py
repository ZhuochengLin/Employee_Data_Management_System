from django.urls import path
from delete import views

urlpatterns = [
    path('', views.delete_employee),
    path('department/', views.delete_department, name='delete-department'),
    path('department/<int:department_id>/', views.delete_department_record, name='delete-department-record'),
    path('employee/', views.delete_employee, name='delete-employee'),
    path('employee/<int:employee_id>/', views.delete_employee_record, name='delete-employee-record'),
    path('salary/', views.delete_salary, name='delete-salary'),
    path('salary/<int:employee_id>/', views.delete_salary_history, name='delete-salary-history'),
    path('salary/<int:employee_id>/<int:salary_id>/', views.delete_salary_record, name='delete-salary-record'),
    path('title/', views.delete_title, name='delete-title'),
    path('title/<int:employee_id>/', views.delete_title_history, name='delete-title-history'),
    path('title/<int:employee_id>/<int:title_id>/', views.delete_title_record, name='delete-title-record'),
    path('assignment/', views.delete_assignment, name='delete-assignment'),
    path('assignment/<int:employee_id>/', views.delete_assignment_history, name='delete-assignment-history'),
    path('assignment/<int:employee_id>/<int:assignment_id>/',
         views.delete_assignment_record, name='delete-assignment-record'),
    path('order/', views.delete_order, name='delete-order'),
    path('order/<int:order_id>/', views.delete_order_record, name='delete-order-record'),
    path('user/', views.delete_user, name='delete-user'),
    path('user/<int:user_id>', views.delete_user_record, name='delete-user-record')

]