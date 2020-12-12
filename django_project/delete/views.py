from django.contrib import messages
from django.contrib.auth.models import User
from django.db.utils import IntegrityError
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse

from navigation.models import Department, Employee, Salary, JobTitle, EmployeeWorksAt, Order, SystemUser
from navigation.views import has_admin_access
from read.forms import EmployeeIdentifier


def delete_department(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    all_departments = Department.find_all_departments()

    return render(request, 'delete/department.html', {'departments': all_departments})


def delete_department_record(request, department_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    all_departments = Department.find_all_departments()
    department = Department.objects.filter(id=department_id)
    if department:
        department = department[0]
    else:
        messages.error(request, "No such department.")
        return render(request, 'delete/department.html', {'departments': all_departments})

    try:
        department.delete()
        return render(request, 'delete/department_success.html')
    except IntegrityError:
        messages.error(request, "Department '{}' is referenced through restricted foreign keys.".format(department.name))
        return render(request, 'delete/department.html', {'departments': all_departments})


def delete_employee(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    all_employees = Employee.find_all_employees()

    return render(request, 'delete/employee.html', {'employees': all_employees})


def delete_employee_record(request, employee_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    all_employees = Employee.find_all_employees()
    employee = Employee.objects.filter(id=employee_id)
    if employee:
        employee = employee[0]
    else:
        messages.error(request, "No such employee.")
        return render(request, 'delete/employee.html', {'employees': all_employees})

    try:
        employee.delete()
        return render(request, 'delete/employee_success.html')
    except IntegrityError:
        messages.error(
            request, "Employee '{} {}' is referenced through restricted foreign keys.".format(
                employee.first_name, employee.last_name))
        return render(request, 'delete/employee.html', {'employees': all_employees})


def delete_salary(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    employee = EmployeeIdentifier()

    if request.method == 'POST':
        employee = EmployeeIdentifier(request.POST)
        if employee.is_valid():
            cleaned_data = employee.cleaned_data
            if cleaned_data.get('id'):
                target_employee = Employee.find_employee_all_info_by_id(cleaned_data.get('id'))
                if target_employee:
                    return render(request, 'delete/salary_employee.html', {'employee': target_employee})

            if cleaned_data.get('first_name') and cleaned_data.get('last_name'):
                target_employee = Employee.find_employee_by_name(
                    cleaned_data.get('first_name'), cleaned_data.get('last_name'))
                target_employee = Employee.find_employee_all_info_by_id(target_employee['employee_id'])
                if target_employee:
                    return render(request, 'delete/salary_employee.html', {'employee': target_employee})

            messages.error(request, "No such employee.")

    return render(request, 'delete/before_search.html', {'employee': employee})


def delete_salary_history(request, employee_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    salary_history = Salary.find_salary_history_by_id(employee_id)
    employee = Employee.find_employee_by_id(employee_id)

    return render(request, 'delete/salary.html', {'salary_history': salary_history, 'employee': employee})


def delete_salary_record(request, employee_id, salary_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    salary = Salary.objects.filter(id=salary_id)
    if salary:
        salary = salary[0]
        try:
            Salary.update_previous_later_salary_dates_when_delete(employee_id, salary_id)
            salary.delete()
            return render(request, 'delete/salary_success.html', {'employee_id': employee_id})
        except IntegrityError as e:
            messages.error(
                request, "This salary record is referenced through restricted foreign keys.")
    else:
        messages.error(request, "No such salary record.")

    salary_history = Salary.find_salary_history_by_id(employee_id)
    employee = Employee.find_employee_by_id(employee_id)
    return render(request, 'delete/salary.html', {'salary_history': salary_history, 'employee': employee})


def delete_title(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    employee = EmployeeIdentifier()

    if request.method == 'POST':
        employee = EmployeeIdentifier(request.POST)
        if employee.is_valid():
            cleaned_data = employee.cleaned_data
            if cleaned_data.get('id'):
                target_employee = Employee.find_employee_all_info_by_id(cleaned_data.get('id'))
                if target_employee:
                    return render(request, 'delete/title_employee.html', {'employee': target_employee})

            if cleaned_data.get('first_name') and cleaned_data.get('last_name'):
                target_employee = Employee.find_employee_by_name(
                    cleaned_data.get('first_name'), cleaned_data.get('last_name'))
                target_employee = Employee.find_employee_all_info_by_id(target_employee['employee_id'])
                if target_employee:
                    return render(request, 'delete/title_employee.html', {'employee': target_employee})

            messages.error(request, "No such employee.")

    return render(request, 'delete/before_search.html', {'employee': employee})


def delete_title_history(request, employee_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    title_history = JobTitle.find_title_history_by_id(employee_id)
    employee = Employee.find_employee_by_id(employee_id)

    return render(request, 'delete/title.html', {'title_history': title_history, 'employee': employee})


def delete_title_record(request, employee_id, title_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    title = JobTitle.objects.filter(id=title_id)
    if title:
        title = title[0]
        try:
            JobTitle.update_previous_later_title_dates_when_delete(employee_id, title_id)
            title.delete()
            return render(request, 'delete/title_success.html', {'employee_id': employee_id})
        except IntegrityError:
            messages.error(
                request, "This title record is referenced through restricted foreign keys.")
    else:
        messages.error(request, "No such title record.")
    title_history = JobTitle.find_title_history_by_id(employee_id)
    employee = Employee.find_employee_by_id(employee_id)
    return render(request, 'delete/title.html', {'title_history': title_history, 'employee': employee})


def delete_assignment(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    employee = EmployeeIdentifier()

    if request.method == 'POST':
        employee = EmployeeIdentifier(request.POST)
        if employee.is_valid():
            cleaned_data = employee.cleaned_data
            if cleaned_data.get('id'):
                target_employee = Employee.find_employee_all_info_by_id(cleaned_data.get('id'))
                if target_employee:
                    return render(request, 'delete/assignment_employee.html', {'employee': target_employee})

            if cleaned_data.get('first_name') and cleaned_data.get('last_name'):
                target_employee = Employee.find_employee_by_name(
                    cleaned_data.get('first_name'), cleaned_data.get('last_name'))
                target_employee = Employee.find_employee_all_info_by_id(target_employee['employee_id'])
                if target_employee:
                    return render(request, 'delete/assignment_employee.html', {'employee': target_employee})

            messages.error(request, "No such employee.")

    return render(request, 'delete/before_search.html', {'employee': employee})


def delete_assignment_history(request, employee_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    assignment_history = EmployeeWorksAt.find_assignment_history_by_id(employee_id)
    employee = Employee.find_employee_by_id(employee_id)

    return render(request, 'delete/assignment.html', {'assignment_history': assignment_history, 'employee': employee})


def delete_assignment_record(request, employee_id, assignment_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    assignment = EmployeeWorksAt.objects.filter(id=assignment_id)
    if assignment:
        assignment = assignment[0]
        try:
            EmployeeWorksAt.update_previous_later_assignment_dates_when_delete(employee_id, assignment_id)
            assignment.delete()
            return render(request, 'delete/assignment_success.html', {'employee_id': employee_id})
        except IntegrityError:
            messages.error(
                request, "This assignment record is referenced through restricted foreign keys.")
    else:
        messages.error(request, "No such assignment record.")

    assignment_history = EmployeeWorksAt.find_assignment_history_by_id(employee_id)
    employee = Employee.find_employee_by_id(employee_id)
    return render(request, 'delete/assignment.html', {'assignment_history': assignment_history, 'employee': employee})


def delete_order(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    orders = Order.find_all_orders()

    return render(request, 'delete/order.html', {'orders': orders})


def delete_order_record(request, order_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    order = Order.objects.filter(id=order_id)
    if order:
        order = order[0]
        try:
            order.delete()
            return render(request, 'delete/order_success.html')
        except IntegrityError:
            messages.error(
                request, "This order record is referenced through restricted foreign keys.")
    else:
        messages.error(request, "No such order.")
        orders = Order.find_all_orders()
        return render(request, 'delete/order.html', {'orders': orders})


def delete_user(request):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    users = SystemUser.find_all_users()

    return render(request, 'delete/user.html', {'users': users})


def delete_user_record(request, user_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    user = User.objects.filter(id=user_id)
    if user:
        user = user[0]
        if user.is_superuser:
            messages.error(request, "You cannot delete a super user.")
            users = SystemUser.find_all_users()
            return render(request, 'delete/user.html', {'users': users})
        try:
            user.delete()
            return render(request, 'delete/user_success.html')
        except IntegrityError:
            messages.error(
                request, "User {} is referenced through restricted foreign keys.".format(user.username))
    else:
        messages.error(request, "No such user.")
    users = SystemUser.find_all_users()
    return render(request, 'delete/user.html', {'users': users})
