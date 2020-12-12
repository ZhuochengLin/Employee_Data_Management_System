from django import forms
from django.contrib import messages
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse

from create.forms import NewEmployee, NewSalary, NewTitle, NewDepartment, NewAssignment, NewOrder
from navigation.models import Salary, Employee, JobTitle, Department, EmployeeWorksAt, SaleStaff
from navigation.views import has_admin_access


def create_employee(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    new_employee = NewEmployee()

    if request.method == 'POST':
        new_employee = NewEmployee(request.POST)
        if new_employee.is_valid():
            new_employee.save()
            return render(request, 'create/employee_success.html')

    return render(request, 'create/employee.html', {'new_employee': new_employee})


def create_salary(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    # check if there are employee records
    all_employees = Employee.find_all_employees()
    if not all_employees:
        messages.error(request, 'No employee record found in the system!')

    new_salary = NewSalary()

    if request.method == 'POST':
        new_salary = NewSalary(request.POST)
        if new_salary.is_valid():
            cleaned_data = request.POST
            e_id = cleaned_data['current_employee']
            new_salary_record = Salary()
            new_salary_record.employee = Employee.objects.get(pk=e_id)
            new_salary_record.from_date = cleaned_data['from_date']
            new_salary_record.to_date = cleaned_data['to_date']
            new_salary_record.amount = cleaned_data['amount']
            # update the old to_date
            Salary.update_salary_to_date(e_id, cleaned_data['from_date'])
            new_salary_record.save()
            return render(request, 'create/salary_success.html')

    return render(request, 'create/salary.html', {'new_salary': new_salary})


def create_title(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    # check if there are employee records
    all_employees = Employee.find_all_employees()
    if not all_employees:
        messages.error(request, 'No employee record found in the system!')

    new_title = NewTitle()

    if request.method == 'POST':
        new_title = NewTitle(request.POST)
        if new_title.is_valid():
            cleaned_data = new_title.cleaned_data
            e_id = cleaned_data['current_employee']
            new_title_record = JobTitle()
            new_title_record.employee = Employee.objects.get(pk=e_id)
            new_title_record.from_date = cleaned_data['from_date']
            new_title_record.to_date = cleaned_data['to_date']
            new_title_record.title = cleaned_data['title']
            # update the old to_date
            JobTitle.update_title_to_date(e_id, cleaned_data['from_date'])
            new_title_record.save()
            return render(request, 'create/title_success.html')

    return render(request, 'create/title.html', {'new_title': new_title})


def create_department(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    new_department = NewDepartment()

    if request.method == 'POST':
        new_department = NewDepartment(request.POST)
        if new_department.is_valid():
            new_department.save()
            return render(request, 'create/department_success.html')

    return render(request, 'create/department.html', {'new_department': new_department})


def create_assignment(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    # check if there are employee records
    all_employees = Employee.find_all_employees()
    if not all_employees:
        messages.error(request, 'No employee record found in the system!')

    # check if there are employee records
    all_departments = Department.find_all_departments()
    if not all_departments:
        messages.error(request, 'No department record found in the system!')

    new_assignment = NewAssignment()

    if request.method == 'POST':
        new_assignment = NewAssignment(request.POST)
        if new_assignment.is_valid():
            cleaned_data = new_assignment.cleaned_data
            e_id = cleaned_data['employee_']
            d_id = cleaned_data['department_']
            EmployeeWorksAt.update_assignment_to_date(e_id, cleaned_data['from_date'])
            new_assignment_record = EmployeeWorksAt()
            new_assignment_record.employee = Employee.objects.get(pk=e_id)
            new_assignment_record.department = Department.objects.get(pk=d_id)
            new_assignment_record.from_date = cleaned_data['from_date']
            new_assignment_record.to_date = cleaned_data['to_date']
            # update the old to_date
            new_assignment_record.save()
            return render(request, 'create/assignment_success.html.html')

    return render(request, 'create/assignment.html', {'new_assignment': new_assignment})


def create_order(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    order = NewOrder()
    sale_staff = SaleStaff.find_all_sale_staff()
    if not sale_staff:
        messages.error(request, "No sale staff in the system. Please assign one first.")
    else:
        if request.method == 'POST':
            order = NewOrder(request.POST)
            if order.is_valid():
                order.save()
                return render(request, 'create/order_success.html')

    return render(request, 'create/order.html', {'order': order})
