from django.contrib import admin
from navigation.models import Employee, Salary, JobTitle, Department, EmployeeWorksAt


admin.site.register(Employee)
admin.site.register(Salary)
admin.site.register(JobTitle)
admin.site.register(Department)
admin.site.register(EmployeeWorksAt)
