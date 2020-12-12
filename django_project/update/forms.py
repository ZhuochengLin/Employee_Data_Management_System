from datetime import date

from crispy_forms.bootstrap import FormActions
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Field, Submit
from django import forms
from django.forms import models

from navigation.models import Employee, Department, Salary, JobTitle, EmployeeWorksAt, Order, SystemUser


class UpdateEmployee(models.ModelForm):

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
                Submit('update-employee', 'Update Employee', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = Employee
        fields = ['first_name', 'last_name', 'gender', 'birth_date', 'hire_date']


class UpdateDepartment(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('name', css_class='form-control', wrapper_class='form-group'),
            FormActions(
                Submit('update-department', 'Update Department', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = Department
        fields = ['name']


class UpdateSalary(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('employee', css_class='form-control', wrapper_class='form-group'),
            Field('amount', css_class='form-control', wrapper_class='form-group'),
            Field('from_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            Field('to_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            FormActions(
                Submit('update-salary', 'Update Salary', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = Salary
        fields = ['employee', 'amount', 'from_date', 'to_date']
        widgets = {
            'employee': forms.HiddenInput()
        }
        labels = {
            'amount': 'Salary'
        }

    def clean(self):
        cleaned_data = super(UpdateSalary, self).clean()
        employee = cleaned_data['employee']
        old_salary = Salary.objects.filter(employee=self.initial['employee'], amount=self.initial['amount'],
                                           from_date=self.initial['from_date'])[0]
        old_salary_id = old_salary.id

        if old_salary.from_date == cleaned_data['from_date'] and old_salary.to_date == cleaned_data['to_date'] \
                and old_salary.amount == cleaned_data['amount'] and old_salary.employee == cleaned_data['employee']:
            raise forms.ValidationError("No changes detected.")

        old_to_date = old_salary.to_date
        new_from_date = cleaned_data['from_date']
        new_to_date = cleaned_data['to_date']

        verify_up_to_now_date_not_changed(old_to_date, new_to_date)

        previous = Salary.find_previous_salary(employee.id, old_salary_id)
        later = Salary.find_later_salary(employee.id, old_salary_id)
        verify_previous_later_dates(previous, later, new_from_date, new_to_date)

        if previous and previous.amount == cleaned_data['amount']:
            raise forms.ValidationError("Same salary as the previous record.")
        if later and later.amount == cleaned_data['amount']:
            raise forms.ValidationError("Same salary as the later record.")


class UpdateTitle(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('employee', css_class='form-control', wrapper_class='form-group'),
            Field('title', css_class='form-control', wrapper_class='form-group'),
            Field('from_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            Field('to_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            FormActions(
                Submit('update-title', 'Update Title', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = JobTitle
        fields = ['title', 'from_date', 'to_date', 'employee']
        widgets = {
            'employee': forms.HiddenInput()
        }

    def clean(self):
        cleaned_data = super(UpdateTitle, self).clean()
        title = cleaned_data['title']
        employee = cleaned_data['employee']
        old_title = JobTitle.objects.filter(employee=self.initial['employee'], title=self.initial['title'],
                                            from_date=self.initial['from_date'])[0]
        old_title_id = old_title.id

        if old_title.from_date == cleaned_data['from_date'] and old_title.to_date == cleaned_data['to_date'] \
                and old_title.title == cleaned_data['title'] and old_title.employee == cleaned_data['employee']:
            raise forms.ValidationError("No changes detected.")

        old_to_date = old_title.to_date
        new_from_date = cleaned_data['from_date']
        new_to_date = cleaned_data['to_date']
        # verify 9999-01-01 not changed
        verify_up_to_now_date_not_changed(old_to_date, new_to_date)

        previous = JobTitle.find_previous_title(employee.id, old_title_id)
        later = JobTitle.find_later_title(employee.id, old_title_id)
        verify_previous_later_dates(previous, later, new_from_date, new_to_date)

        if previous and previous.title == title:
            raise forms.ValidationError("Same title as the previous record.")
        if later and later.title == title:
            raise forms.ValidationError("Same title as the later record.")


def verify_previous_later_dates(previous, later, new_from_date, new_to_date):
    """
    This method verifies: the new from date is > the to date of a previous record, the new to date < the from date of
    a later record.

    :param previous:      a previous record
    :param later:         a later record
    :param new_from_date: updated from date of the current record
    :param new_to_date:   updated to date of the current record
    :return:              raise ValidationError if not valid
    """
    previous_from_date = previous.from_date if previous else date(1, 1, 1)
    later_to_date = later.to_date if later else date(9999, 2, 2)
    if new_from_date >= new_to_date:
        raise forms.ValidationError("From date should be earlier than the to date.")
    if new_from_date <= previous_from_date:
        raise forms.ValidationError("Invalid from date, should be later than {}.".format(previous_from_date))

    if new_to_date >= later_to_date:
        raise forms.ValidationError("Invalid to date, should be earlier than {}.".format(later_to_date))


def verify_up_to_now_date_not_changed(old_to_date, new_to_date):
    """
    If the current to date is 9999-01-01, then it should not be changed.
    :param old_to_date:    current to date
    :param new_to_date:    updated to date
    :return:               raise ValidationError if not valid
    """
    if old_to_date == date(9999, 1, 1) and old_to_date != new_to_date:
        raise forms.ValidationError(
            'Do not modify the "9999-01-01" to date.')


class UpdateAssignment(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('employee', css_class='hidden form-control', wrapper_class='form-group'),
            Field('department', css_class='form-control', wrapper_class='form-group'),
            Field('from_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            Field('to_date', css_class='form-control', wrapper_class='form-group',
                  data_provide='datepicker', data_date_format="yyyy-mm-dd", data_date_keyboard_navigation="false"),
            FormActions(
                Submit('update-assignment', 'Update Assignment', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = EmployeeWorksAt
        fields = ['employee', 'department', 'from_date', 'to_date']
        widgets = {
            'employee': forms.HiddenInput()
        }

    def clean(self):
        cleaned_data = super(UpdateAssignment, self).clean()
        department = cleaned_data['department']
        employee = cleaned_data['employee']
        old_assignment = EmployeeWorksAt.objects.filter(
            department=self.initial['department'], employee=self.initial['employee'],
            from_date=self.initial['from_date'])[0]
        old_assignment_id = old_assignment.id

        # detect change
        if old_assignment.from_date == cleaned_data['from_date'] and old_assignment.to_date == cleaned_data['to_date'] \
                and old_assignment.department == department \
                and old_assignment.employee == employee:
            raise forms.ValidationError("No changes detected.")

        old_to_date = old_assignment.to_date
        new_from_date = cleaned_data['from_date']
        new_to_date = cleaned_data['to_date']

        verify_up_to_now_date_not_changed(old_to_date, new_to_date)

        previous = EmployeeWorksAt.find_previous_assignment(employee.id, old_assignment_id)
        later = EmployeeWorksAt.find_later_assignment(employee.id, old_assignment_id)
        verify_previous_later_dates(previous, later, new_from_date, new_to_date)
        if previous and previous.department == department:
            raise forms.ValidationError("Same department as the previous assignment.")
        if later and later.department == department:
            raise forms.ValidationError("Same department as the later assignment.")


class OrderForm(models.ModelForm):
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
                Submit('update-order', 'Update Order', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = Order
        fields = ['sale_staff', 'item_name', 'unit_price', 'quantity', 'status']


class SystemUserForm(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('access_level', css_class='form-control', wrapper_class='form-group'),
            FormActions(
                Submit('update-user', 'Update User', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    class Meta:
        model = SystemUser
        fields = ['access_level']
