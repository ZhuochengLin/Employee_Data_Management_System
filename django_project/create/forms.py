from crispy_forms.bootstrap import FormActions
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Submit, Fieldset, MultiField, Div, Field, Button
from django.forms import models
from django import forms
from django.contrib.admin.widgets import AdminDateWidget
from navigation.models import Employee, Salary, JobTitle, Department, EmployeeWorksAt, Order
from datetime import date


class NewEmployee(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('first_name', css_class='form-control', wrapper_class='form-group'),
            Field('last_name', css_class='form-control', wrapper_class='form-group'),
            Field('gender', css_class='form-control', wrapper_class='form-group'),
            Field('birth_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            Field('hire_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            FormActions(
                Submit('create-employee', 'Create Employee', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = Employee
        fields = ['first_name', 'last_name', 'gender', 'birth_date', 'hire_date']
        widgets = {
            # remove input history
            'birth_date': forms.DateInput(attrs={'autocomplete': 'off'}),
            'hire_date': forms.DateInput(attrs={'autocomplete': 'off'})
        }


class NewSalary(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('current_employee', css_class='form-control', wrapper_class='form-group'),
            Field('amount', css_class='form-control', wrapper_class='form-group'),
            Field('from_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            Field('to_date', css_class='form-control', wrapper_class='form-group'),
            FormActions(
                Submit('create-salary', 'Create Salary', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )
        # dynamically change choice field
        self.fields['current_employee'].choices = get_all_employees()
        # read only
        self.fields['to_date'].widget.attrs['readonly'] = True

    current_employee = forms.ChoiceField(choices=())
    to_date = forms.DateField(initial="9999-01-01")

    class Meta:
        model = Salary
        fields = ['current_employee', 'amount', 'from_date', 'to_date']
        widgets = {
            'from_date': forms.DateInput(attrs={'autocomplete': 'off'}),
            'to_date': forms.DateInput(attrs={'autocomplete': 'off'})
        }
        labels = {
            'amount': 'Salary'
        }

    def clean(self):
        cleaned_data = super(NewSalary, self).clean()
        e_id = cleaned_data['current_employee']
        previous_date = Salary.find_current_salary_by_id(e_id)
        previous_date = previous_date['from_date'] if previous_date else date(1, 1, 1)

        date_check(cleaned_data, previous_date)
        check_hire(e_id, cleaned_data['from_date'])


class NewTitle(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('current_employee', css_class='form-control', wrapper_class='form-group'),
            Field('title', css_class='form-control', wrapper_class='form-group'),
            Field('from_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            Field('to_date', css_class='form-control', wrapper_class='form-group',
                  data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            FormActions(
                Submit('create-title', 'Create Title', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )
        # dynamically change choice field
        self.fields['current_employee'].choices = get_all_employees()
        # read only
        self.fields['to_date'].widget.attrs['readonly'] = True

    current_employee = forms.ChoiceField(choices=())

    class Meta:
        model = JobTitle
        fields = ['title', 'from_date', 'to_date']
        widgets = {
            'from_date': forms.DateInput(attrs={'autocomplete': 'off'}),
            'to_date': forms.DateInput(attrs={'autocomplete': 'off'})
        }

    def clean(self):
        cleaned_data = super(NewTitle, self).clean()
        e_id = cleaned_data['current_employee']
        previous_date = JobTitle.find_current_title_by_id(e_id)
        previous_date = previous_date['from_date'] if previous_date else date(1, 1, 1)

        date_check(cleaned_data, previous_date)
        check_hire(e_id, cleaned_data['from_date'])


class NewDepartment(models.ModelForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('name', css_class='form-control', wrapper_class='form-group'),
            FormActions(
                Submit('create-department', 'Create Department', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = Department
        fields = ['name']


class NewAssignment(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('employee_', css_class='form-control', wrapper_class='form-group'),
            Field('department_', css_class='form-control', wrapper_class='form-group'),
            Field('from_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            Field('to_date', css_class='form-control', wrapper_class='form-group',
                  data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            FormActions(
                Submit('create-assignment', 'Create Assignment', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )
        # dynamically change employee choice field
        self.fields['employee_'].choices = get_all_employees()
        # dynamically change employee choice field
        self.fields['department_'].choices = get_all_departments()
        # read only
        self.fields['to_date'].widget.attrs['readonly'] = True

    employee_ = forms.ChoiceField(choices=())
    department_ = forms.ChoiceField(choices=())

    class Meta:
        model = EmployeeWorksAt
        fields = ['from_date', 'to_date']
        widgets = {
            'from_date': forms.DateInput(attrs={'autocomplete': 'off'}),
            'to_date': forms.DateInput(attrs={'autocomplete': 'off'})
        }

    def clean(self):
        cleaned_data = super(NewAssignment, self).clean()
        e_id = cleaned_data['employee_']
        previous = EmployeeWorksAt.find_current_assignment_by_id(e_id)
        previous_date = previous['from_date'] if previous else date(1, 1, 1)
        previous_department = previous['department_id'] if previous else ''

        date_check(cleaned_data, previous_date)

        if cleaned_data['department_'] == str(previous_department):
            raise forms.ValidationError(
                "The employee has already been assigned to this department."
            )
        check_hire(e_id, cleaned_data['from_date'])


def get_all_employees():
    all_employees = Employee.find_all_employees()
    if not all_employees:
        employees = [('', '')]
    else:
        employees = [(i['employee_id'], i['first_name'] + " " + i['last_name']) for i in all_employees]
    return employees


def get_all_departments():
    all_departments = Department.find_all_departments()
    if not all_departments:
        departments = [('', '')]
    else:
        departments = [(i['id'], i['name']) for i in all_departments]
    return departments


def date_check(cleaned_data, previous_date):
    if cleaned_data['from_date'] <= previous_date:
        raise forms.ValidationError(
            "New from date should be later than the latest date, {}.".format(previous_date))
    if cleaned_data['to_date'] != date(9999, 1, 1):
        raise forms.ValidationError(
            'Do not modify the "9999-01-01" to date.')


def check_hire(e_id, from_date):
    employee = Employee.objects.filter(id=e_id)
    if employee:
        employee = employee[0]
        if from_date < employee.hire_date:
            raise forms.ValidationError(
                "From date cannot be earlier than the hire date, {}.".format(employee.hire_date))


class NewOrder(models.ModelForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('sale_staff', css_class='form-control', wrapper_class='form-group'),
            Field('item_name', css_class='form-control', wrapper_class='form-group'),
            Field('quantity', css_class='form-control', wrapper_class='form-group'),
            Field('unit_price', css_class='form-control', wrapper_class='form-group'),
            Field('status', css_class='form-control', wrapper_class='form-group'),
            FormActions(
                Submit('create-order', 'Create Order', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = Order
        fields = ['sale_staff', 'item_name', 'unit_price', 'quantity', 'status']



