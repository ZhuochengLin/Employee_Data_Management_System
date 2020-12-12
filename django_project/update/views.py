from django.contrib import messages
from django.contrib.auth.models import User
from django.forms import modelformset_factory
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse

from navigation.models import Employee, Department, Salary, JobTitle, EmployeeWorksAt, Order, SystemUser
from navigation.views import has_admin_access
from update.forms import UpdateEmployee, UpdateDepartment, UpdateSalary, UpdateTitle, UpdateAssignment, OrderForm, \
    SystemUserForm

NO_CHANGE = "No change detected."


def update_employee(request, employee_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    employee = Employee.objects.filter(id=employee_id)
    if not employee:
        return render(request, 'read/show_employee_result.html', {'employee': None})
    else:
        employee = employee[0]

    initial_data = {'id': employee_id, 'first_name': employee.first_name, 'last_name': employee.last_name,
                    'birth_date': employee.birth_date, 'gender': employee.gender, 'hire_date': employee.hire_date}

    forms = UpdateEmployee(initial=initial_data)
    if request.method == 'POST':
        forms = UpdateEmployee(request.POST, instance=employee)
        if forms.has_changed():
            if forms.is_valid():
                forms.save()
                return render(request, 'update/employee_success.html')
        else:
            messages.error(request, NO_CHANGE)

    return render(request, 'update/employee.html', {'employee': forms, 'employee_id': initial_data['id']})


def update_department(request, department_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    department = Department.objects.filter(id=department_id)
    if department:
        department = department[0]
    else:
        return render(request, 'update/department.html', {'department': None, 'id': None})

    department_form = UpdateDepartment(initial={'name': department.name})
    if request.method == 'POST':
        department_form = UpdateDepartment(request.POST, instance=department)
        if department_form.has_changed():
            if department_form.is_valid():
                department_form.save()
                return render(request, 'update/department_success.html')
        else:
            messages.error(request, NO_CHANGE)
    return render(request, 'update/department.html', {'department': department_form, 'id': department_id})


def update_salary(request, employee_id, salary_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    employee = Employee.find_employee_by_id(employee_id)
    current_salary = Salary.objects.filter(id=salary_id)
    salary = UpdateSalary()
    if current_salary:
        current_salary = current_salary[0]
        initial_data = {'amount': current_salary.amount, 'from_date': current_salary.from_date,
                        'to_date': current_salary.to_date, 'employee': current_salary.employee}
        salary = UpdateSalary(initial=initial_data)
    else:
        messages.error(request, "No such salary record.")

    if request.method == 'POST':
        salary = UpdateSalary(request.POST, instance=current_salary)
        if salary.is_valid():
            cleaned_data = salary.cleaned_data
            current_salary.amount = cleaned_data['amount']
            current_salary.from_date = cleaned_data['from_date']
            current_salary.to_date = cleaned_data['to_date']
            Salary.update_previous_later_salary_dates(
                employee_id, salary_id, cleaned_data['from_date'], cleaned_data['to_date'])
            current_salary.save()
            return render(request, 'update/salary_success.html', {'employee_id': employee_id})

    return render(request, 'update/salary.html', {'salary': salary, 'salary_id': salary_id, 'employee': employee})


def update_title(request, employee_id, title_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    employee = Employee.find_employee_by_id(employee_id)
    current_title = JobTitle.objects.filter(id=title_id)
    title = UpdateTitle()
    if current_title:
        current_title = current_title[0]
        initial_data = {'title': current_title.title, 'employee': current_title.employee,
                        'from_date': current_title.from_date, 'to_date': current_title.to_date}
        title = UpdateTitle(initial=initial_data)
    else:
        messages.error(request, "No such title record.")

    if request.method == 'POST':
        title = UpdateTitle(request.POST, instance=current_title)
        if title.is_valid():
            cleaned_data = title.cleaned_data
            current_title.title = cleaned_data['title']
            current_title.from_date = cleaned_data['from_date']
            current_title.to_date = cleaned_data['to_date']
            JobTitle.update_previous_later_title_dates(
                employee_id, title_id, cleaned_data['from_date'], cleaned_data['to_date'])
            current_title.save()
            return render(request, 'update/title_success.html', {'employee_id': employee_id})

    return render(request, 'update/title.html', {'title': title, 'title_id': title, 'employee': employee})


def update_assignment(request, employee_id, assignment_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    employee = Employee.find_employee_by_id(employee_id)
    current_assignment = EmployeeWorksAt.objects.filter(id=assignment_id)
    assignment = UpdateAssignment()
    if current_assignment:
        current_assignment = current_assignment[0]
        initial_data = {'department': current_assignment.department, 'employee': current_assignment.employee,
                        'from_date': current_assignment.from_date,
                        'to_date': current_assignment.to_date
                        }
        assignment = UpdateAssignment(initial=initial_data)
    else:
        messages.error(request, "No such assignment record.")

    if request.method == 'POST':
        assignment = UpdateAssignment(request.POST, instance=current_assignment)
        if assignment.is_valid():
            cleaned_data = assignment.cleaned_data
            current_assignment.department = cleaned_data['department']
            current_assignment.employee = cleaned_data['employee']
            current_assignment.from_date = cleaned_data['from_date']
            current_assignment.to_date = cleaned_data['to_date']
            EmployeeWorksAt.update_previous_later_assignment_dates(
                employee_id, assignment_id, cleaned_data['from_date'], cleaned_data['to_date'])
            current_assignment.save()
            return render(request, 'update/assignment_success.html', {'employee_id': employee_id})

    return render(request, 'update/assignment.html', {'assignment': assignment, 'employee': employee})


def update_order_record(request, order_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    order_object = Order.objects.filter(id=order_id)
    if order_object:
        order_object = order_object[0]
    else:
        return render(request, 'read/show_orders.html')

    order = OrderForm(instance=order_object)

    if request.method == 'POST':
        order = OrderForm(request.POST, instance=order_object)
        if order.has_changed():
            if order.is_valid():
                order.save()
                return render(request, 'update/order_success.html')
        else:
            messages.error(request, NO_CHANGE)

    return render(request, 'update/order.html', {'order': order})


def update_user_record(request, user_id):
    if not has_admin_access(request):
        return HttpResponseRedirect(reverse('guest'))

    user = User.objects.filter(id=user_id)
    if user:
        user = user[0]
    else:
        messages.error(request, "No such user.")

    if request.method == 'POST':
        system_user = SystemUser.objects.filter(user_id=user_id)
        if system_user:
            system_user_form = SystemUserForm(request.POST, instance=system_user[0])
            system_user_form.save()
            return render(request, 'update/user_success.html')
        else:
            messages.error(request, "No such user.")

    system_user_form = SystemUserForm()

    return render(request, 'update/user.html', {'system_user': system_user_form, 'username': user.username})
