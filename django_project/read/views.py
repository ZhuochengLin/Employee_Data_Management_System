from django.contrib.auth.decorators import login_required
from django.db import connections
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse

from navigation.views import has_admin_access
from read.forms import EmployeeIdentifier
from navigation.models import Employee, Salary, JobTitle, EmployeeWorksAt, Department, SaleStaff, Order, SystemUser


# read employee
def read_employee(request):
    forms = EmployeeIdentifier()

    if request.method == 'POST':
        forms = EmployeeIdentifier(request.POST)
        if forms.is_valid():
            cleaned_data = forms.cleaned_data
            result = None
            if cleaned_data.get('id'):
                e_id = cleaned_data.get('id')
                result = Employee.find_employee_all_info_by_id(e_id)
                if result:
                    return render(request, 'read/show_employee_result.html', {'employee': result})
            if cleaned_data.get('first_name') and cleaned_data.get('last_name'):
                first_name = cleaned_data.get('first_name')
                last_name = cleaned_data.get('last_name')
                result = find_employee_all_info_by_name(first_name, last_name)
            return render(request, 'read/show_employee_result.html', {'employee': result})

    return render(request, 'read/read_employee.html', {'forms': forms})


def find_employee_all_info_by_name(first_name, last_name):
    employee = Employee.find_employee_by_name(first_name, last_name)
    if employee:
        result = Employee.find_employee_all_info_by_id(employee['employee_id'])
    else:
        return None
    return result


def read_employee_salary(request, employee_id):
    """
    Read salary history for a specific employee by id.
    :param request: http request
    :param employee_id: the target employee id
    :return: page render result
    """
    employee = Employee.find_employee_by_id(employee_id)
    salary_history = Salary.find_salary_history_by_id(employee_id)
    return render(request, 'read/show_salary_history.html', {'salary_history': salary_history, 'employee': employee})


def read_employee_title(request, employee_id):
    employee = Employee.find_employee_by_id(employee_id)
    title_history = JobTitle.find_title_history_by_id(employee_id)
    return render(request, 'read/show_title_history.html', {'title_history': title_history, 'employee': employee})


def read_employee_assignment(request, employee_id):
    employee = Employee.find_employee_by_id(employee_id)
    assignment_history = EmployeeWorksAt.find_assignment_history_by_id(employee_id)
    return render(request, 'read/show_assignment.html',
                  {'assignment_history': assignment_history, 'employee': employee})


def read_department(request):
    departments = Department.find_all_departments()
    return render(request, 'read/show_departments.html', {'departments': departments})


def read_employee_all(request):
    employees = Employee.find_all_employees()
    return render(request, 'read/show_all_employees.html', {'employees': employees})


def read_employee_info(request, employee_id):
    employee = Employee.find_employee_all_info_by_id(employee_id)
    return render(request, 'read/show_employee_result.html', {'employee': employee})


def read_sale_staff(request):
    sale_staff = SaleStaff.find_all_sale_staff()

    return render(request, 'read/show_sale_staff.html', {'employees': sale_staff})


def read_order(request):
    orders = Order.find_all_orders()
    return render(request, 'read/show_orders.html', {'orders': orders})


def read_user(request):
    users = SystemUser.find_all_users()
    return render(request, 'read/show_users.html', {'users': users})
