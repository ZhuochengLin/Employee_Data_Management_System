from django.urls import path
from update import views
from read.views import read_employee, read_department, read_employee_salary, read_employee_title, \
    read_employee_assignment, read_order, read_user, read_employee_all

urlpatterns = [
    path('', read_employee),
    path('employee/', read_employee_all, name='update-employee'),
    path('employee/<int:employee_id>', views.update_employee, name='update-employee-record'),
    path('department/', read_department, name='update-department'),
    path('department/<int:department_id>', views.update_department, name='update-department-record'),
    path('salary/', read_employee, name='update-salary'),
    path('salary/<int:employee_id>/', read_employee_salary, name='update-salary-history'),
    path('salary/<int:employee_id>/<int:salary_id>/', views.update_salary, name='update-salary-record'),
    path('title/', read_employee, name='update-title'),
    path('title/<int:employee_id>/', read_employee_title, name='update-title-history'),
    path('title/<int:employee_id>/<int:title_id>/', views.update_title, name='update-title-record'),
    path('assignment/', read_employee, name='update-assignment'),
    path('assignment/<int:employee_id>/', read_employee_assignment, name='update-assignment-history'),
    path('assignment/<int:employee_id>/<int:assignment_id>/', views.update_assignment, name='update-assignment-record'),
    path('order/', read_order, name='update-order'),
    path('order/<int:order_id>/', views.update_order_record, name='update-order-record'),
    path('user/', read_user, name='update-user'),
    path('user/<int:user_id>/', views.update_user_record, name='update-user-record')

]
