from crispy_forms.bootstrap import FormActions
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit, Layout, Field
from django import forms


GENDER_CHOICES = [
    ('M', 'Male'),
    ('F', 'Female')
]


class EmployeeIdentifier(forms.Form):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('id', css_class='form-control', wrapper_class='form-group'),
            Field('first_name', css_class='form-control', wrapper_class='form-group'),
            Field('last_name', css_class='form-control', wrapper_class='form-group'),
            FormActions(
                Submit('search-employee', 'Search', css_class='btn btn-primary'),
                css_class='form-group pt-3'
            )
        )

    id = forms.IntegerField(required=False)
    first_name = forms.CharField(max_length=100, required=False)
    last_name = forms.CharField(max_length=100, required=False)

    def clean(self):
        clean_data = super().clean()
        if not (clean_data.get('id') or (clean_data.get('first_name') and clean_data.get('last_name'))):
            raise forms.ValidationError("You must provide an ID or NAME to search.")

