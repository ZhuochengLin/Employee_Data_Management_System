from crispy_forms.bootstrap import FormActions
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Field, Submit
from django import forms
from django.contrib.auth.models import User
from django.forms import models

from navigation.models import SystemUser


class UserRegisterForm(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_show_errors = False
        self.helper.form_tag = False
        self.helper.layout = Layout(
            Field('username', css_class='form-control', wrapper_class='form-group'),
            Field('password', css_class='form-control', wrapper_class='form-group'),
        )

    class Meta:
        model = User
        fields = ['username', 'password']
        widgets = {
            'password': forms.PasswordInput(),
        }
        help_texts = {
            'username': None
        }


class SystemUserForm(models.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_tag = False
        self.helper.form_show_errors = False
        self.helper.layout = Layout(
            Field('user', css_class='form-control', wrapper_class='form-group'),
            Field('access_level', css_class='form-control', wrapper_class='form-group'),
        )

    class Meta:
        model = SystemUser
        fields = ['user', 'access_level']
        widgets = {
            'user': forms.HiddenInput(),
            'access_level': forms.HiddenInput()
        }

