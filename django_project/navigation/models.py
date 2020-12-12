from decimal import Decimal

from django.contrib.auth.models import User
from django.core.validators import MinValueValidator
from django.db import models
from django.db.models import UniqueConstraint

GENDER_CHOICES = [
    ('M', 'Male'),
    ('F', 'Female')
]

ACCESS_LEVEL = [
    ('A', 'Admin'),
    ('G', 'Guest')
]


class SystemUser(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    access_level = models.CharField(max_length=10, choices=ACCESS_LEVEL, default=ACCESS_LEVEL[1][0])

    def __str__(self):
        return self.user.username

    @staticmethod
    def find_all_users():
        result = []
        response = SystemUser.objects.raw('CALL find_all_users()')
        if response:
            for r in response:
                result.append(
                    {'user_id': r.id, 'username': r.username, 'access_level': 'Guest' if r.access_level == 'G' else 'Admin'})
        else:
            return None

        return result


class Department(models.Model):
    name = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.name

    @staticmethod
    def find_all_departments():
        result = []
        response = Department.objects.raw('CALL find_all_departments()')
        if response:
            for r in response:
                result.append({'id': r.id, 'name': r.name})
        else:
            return None

        return result


class Employee(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    birth_date = models.DateField()
    gender = models.CharField(choices=GENDER_CHOICES, max_length=50)
    hire_date = models.DateField()
    works_at = models.ManyToManyField(Department, through='EmployeeWorksAt')

    class Meta:
        constraints = [
            UniqueConstraint(fields=['first_name', 'last_name'], name='unique_name')
        ]

    def __str__(self):
        return '{} {}'.format(self.first_name, self.last_name)

    @staticmethod
    def find_employee_by_id(e_id):
        result = Employee.objects.raw('CALL search_employee_by_id(%s)', params=[e_id])
        if result:
            result = result[0]
        else:
            return None

        return {'employee_id': result.id, 'first_name': result.first_name, 'last_name': result.last_name,
                'gender': 'Male' if result.gender == 'M' else 'Female',
                'birth_date': result.birth_date, 'hire_date': result.hire_date}

    @staticmethod
    def find_employee_by_name(first_name, last_name):
        result = Employee.objects.raw('CALL search_employee_by_name(%s, %s)', params=[first_name, last_name])
        if result:
            result = result[0]
        else:
            return None

        return {'employee_id': result.id, 'first_name': result.first_name, 'last_name': result.last_name,
                'gender': 'Male' if result.gender == 'M' else 'Female',
                'birth_date': result.birth_date, 'hire_date': result.hire_date}

    @staticmethod
    def find_all_employees():
        result = []
        response = Employee.objects.raw('CALL find_all_employees()')
        if response:
            for r in response:
                result.append({'employee_id': r.id, 'first_name': r.first_name, 'last_name': r.last_name,
                               'gender': 'Male' if r.gender == 'M' else 'Female',
                               'birth_date': r.birth_date, 'hire_date': r.hire_date,
                               'salary': r.salary, 'title': r.title, 'department': r.department_name})
        else:
            return None

        return result

    @staticmethod
    def find_employee_all_info_by_id(e_id):
        result = Employee.objects.raw('CALL search_employee_all_info_by_id(%s)', params=[e_id])
        if result:
            result = result[0]
        else:
            return None

        return {'employee_id': result.id, 'first_name': result.first_name, 'last_name': result.last_name,
                'gender': 'Male' if result.gender == 'M' else 'Female',
                'birth_date': result.birth_date, 'hire_date': result.hire_date,
                'salary': result.salary, 'title': result.title, 'department': result.department_name}


class EmployeeWorksAt(models.Model):
    employee = models.ForeignKey(Employee, on_delete=models.RESTRICT)
    department = models.ForeignKey(Department, on_delete=models.RESTRICT)
    from_date = models.DateField()
    to_date = models.DateField(default='9999-01-01')

    def __str__(self):
        return 'Employee {} works at {} department from {} to {}.'.format(
            self.employee, self.department, self.from_date, self.to_date)

    @staticmethod
    def update_assignment_to_date(e_id, new_to_date):
        assignment_history = EmployeeWorksAt.find_assignment_history_by_id(e_id)
        if assignment_history:
            response = EmployeeWorksAt.objects.raw('CALL update_assignment_to_date(%s)', params=[e_id])[0]
            response.to_date = new_to_date
            response.save()

    @staticmethod
    def find_assignment_history_by_id(e_id):
        result = []
        response = EmployeeWorksAt.objects.raw('CALL search_assignment_history_by_id(%s)', params=[e_id])
        if response:
            for r in response:
                result.append({'employee_id': r.employee_id, 'department_name': r.department_name,
                               'department_id': r.department_id, 'from_date': r.from_date, 'to_date': r.to_date,
                               'assignment_id': r.id})
        else:
            return None

        return result

    @staticmethod
    def find_current_assignment_by_id(e_id):
        result = EmployeeWorksAt.objects.raw('CALL search_current_assignment_by_id(%s)', params=[e_id])
        if result:
            result = result[0]
        else:
            return None

        return {'employee_id': result.employee_id, 'department_id': result.department_id,
                'from_date': result.from_date, 'to_date': result.to_date, 'assignment_id': result.id}

    @staticmethod
    def find_previous_assignment(e_id, a_id):
        response = EmployeeWorksAt.objects.raw('CALL search_previous_assignment(%s, %s)', params=[e_id, a_id])
        if response:
            response = response[0]
        else:
            return None

        return response

    @staticmethod
    def find_later_assignment(e_id, a_id):
        response = EmployeeWorksAt.objects.raw('CALL search_later_assignment(%s, %s)', params=[e_id, a_id])
        if response:
            response = response[0]
        else:
            return None

        return response

    @staticmethod
    def update_previous_later_assignment_dates(e_id, a_id, current_from_date, current_to_date):
        previous = EmployeeWorksAt.find_previous_assignment(e_id, a_id)
        later = EmployeeWorksAt.find_later_assignment(e_id, a_id)
        if previous and previous.to_date > current_from_date:
            previous.to_date = current_from_date
            previous.save()
        if later and later.from_date < current_to_date:
            later.from_date = current_to_date
            later.save()

    @staticmethod
    def update_previous_later_assignment_dates_when_delete(e_id, s_id):
        previous = EmployeeWorksAt.find_previous_assignment(e_id, s_id)
        later = EmployeeWorksAt.find_later_assignment(e_id, s_id)
        # last
        if not later and previous:
            previous.to_date = '9999-01-01'
            previous.save()
        # middle
        elif later and previous:
            later.from_date = previous.to_date
            later.save()


class Salary(models.Model):
    employee = models.ForeignKey(Employee, on_delete=models.CASCADE)
    amount = models.IntegerField()
    from_date = models.DateField()
    to_date = models.DateField(default='9999-01-01')

    def __str__(self):
        return 'Employee {} earns {}$ from {} to {}.'.format(self.employee, self.amount, self.from_date, self.to_date)

    @staticmethod
    def find_current_salary_by_id(e_id):
        result = Salary.objects.raw('CALL search_current_salary_by_id(%s)', params=[e_id])
        if result:
            result = result[0]
        else:
            return None

        return {'employee_id': result.employee_id, 'salary': result.amount,
                'from_date': result.from_date, 'to_date': result.to_date}

    @staticmethod
    def find_salary_history_by_id(e_id):
        result = []
        response = Salary.objects.raw('CALL search_salary_history_by_id(%s)', params=[e_id])
        if response:
            for r in response:
                result.append({'salary': r.amount, 'from_date': r.from_date, 'to_date': r.to_date, 'salary_id': r.id})
        else:
            return None

        return result

    @staticmethod
    def update_salary_to_date(e_id, new_to_date):
        salary_history = Salary.find_salary_history_by_id(e_id)
        if salary_history:
            response = Salary.objects.raw('CALL update_salary_to_date(%s)', params=[e_id])[0]
            response.to_date = new_to_date
            response.save()

    @staticmethod
    def find_previous_salary(e_id, s_id):
        response = Salary.objects.raw('CALL search_previous_salary(%s, %s)', params=[e_id, s_id])
        if response:
            response = response[0]
        else:
            return None

        return response

    @staticmethod
    def find_later_salary(e_id, s_id):
        response = Salary.objects.raw('CALL search_later_salary(%s, %s)', params=[e_id, s_id])
        if response:
            response = response[0]
        else:
            return None

        return response

    @staticmethod
    def update_previous_later_salary_dates(e_id, s_id, current_from_date, current_to_date):
        previous = Salary.find_previous_salary(e_id, s_id)
        later = Salary.find_later_salary(e_id, s_id)
        if previous and previous.to_date > current_from_date:
            previous.to_date = current_from_date
            previous.save()
        if later and later.from_date < current_to_date:
            later.from_date = current_to_date
            later.save()

    @staticmethod
    def update_previous_later_salary_dates_when_delete(e_id, s_id):
        previous = Salary.find_previous_salary(e_id, s_id)
        later = Salary.find_later_salary(e_id, s_id)
        # last
        if not later and previous:
            previous.to_date = '9999-01-01'
            previous.save()
        # middle
        elif later and previous:
            later.from_date = previous.to_date
            later.save()


class JobTitle(models.Model):
    employee = models.ForeignKey(Employee, on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    from_date = models.DateField()
    to_date = models.DateField(default='9999-01-01')

    def __str__(self):
        return 'Employee {} works as {} from {} to {}.'.format(self.employee, self.title, self.from_date, self.to_date)

    @staticmethod
    def find_current_title_by_id(e_id):
        result = JobTitle.objects.raw('CALL search_current_title_by_id(%s)', params=[e_id])
        if result:
            result = result[0]
        else:
            return None

        return {'employee_id': result.employee_id, 'title': result.title,
                'from_date': result.from_date, 'to_date': result.to_date}

    @staticmethod
    def find_title_history_by_id(e_id):
        result = []
        response = JobTitle.objects.raw('CALL search_title_history_by_id(%s)', params=[e_id])
        if response:
            for r in response:
                result.append({'title': r.title, 'from_date': r.from_date, 'to_date': r.to_date,
                               'title_id': r.id, 'employee_id': r.employee_id})
        else:
            return None

        return result

    @staticmethod
    def update_title_to_date(e_id, new_to_date):
        title_history = JobTitle.find_title_history_by_id(e_id)
        if title_history:
            response = JobTitle.objects.raw('CALL update_title_to_date(%s)', params=[e_id])[0]
            response.to_date = new_to_date
            response.save()

    @staticmethod
    def find_previous_title(e_id, t_id):
        response = JobTitle.objects.raw('CALL search_previous_title(%s, %s)', params=[e_id, t_id])
        if response:
            response = response[0]
        else:
            return None

        return response

    @staticmethod
    def find_later_title(e_id, t_id):
        response = JobTitle.objects.raw('CALL search_later_title(%s, %s)', params=[e_id, t_id])
        if response:
            response = response[0]
        else:
            return None

        return response

    @staticmethod
    def update_previous_later_title_dates(e_id, t_id, current_from_date, current_to_date):
        previous = JobTitle.find_previous_title(e_id, t_id)
        later = JobTitle.find_later_title(e_id, t_id)
        if previous and previous.to_date > current_from_date:
            previous.to_date = current_from_date
            previous.save()
        if later and later.from_date < current_to_date:
            later.from_date = current_to_date
            later.save()

    @staticmethod
    def update_previous_later_title_dates_when_delete(e_id, s_id):
        previous = JobTitle.find_previous_title(e_id, s_id)
        later = JobTitle.find_later_title(e_id, s_id)
        # last
        if not later and previous:
            previous.to_date = '9999-01-01'
            previous.save()
        # middle
        elif later and previous:
            later.from_date = previous.to_date
            later.save()


class SaleStaff(models.Model):
    employee = models.ForeignKey(Employee, on_delete=models.CASCADE)

    def __str__(self):
        return '{} {}'.format(self.employee.first_name, self.employee.last_name)

    @staticmethod
    def find_all_sale_staff():
        result = []
        response = SaleStaff.objects.raw('CALL find_all_sale_staff()')
        if response:
            employees = [r.employee_id for r in response]
            for i in employees:
                result.append(Employee.find_employee_all_info_by_id(i))
        else:
            return None

        return result


class Order(models.Model):
    sale_staff = models.ForeignKey(SaleStaff, on_delete=models.RESTRICT)
    item_name = models.CharField(max_length=100)
    quantity = models.IntegerField(default=1, validators=[MinValueValidator(0)])
    unit_price = models.DecimalField(max_digits=10, decimal_places=2, validators=[MinValueValidator(Decimal('0.01'))],
                                     default=0)
    status = models.CharField(max_length=10, choices=[('F', 'Finished'), ('A', 'Active')], default='A')

    def __str__(self):
        return "Sale staff {} {} is responsible for {}'s order.".format(
            self.sale_staff.employee.first_name, self.sale_staff.employee.last_name, self.account)

    @staticmethod
    def find_all_orders():
        result = []
        response = SaleStaff.objects.raw('CALL find_all_orders()')
        if response:
            for r in response:
                result.append({'employee_id': r.employee_id, 'first_name': r.first_name, 'last_name': r.last_name,
                               'item_name': r.item_name, 'quantity': r.quantity, 'unit_price': r.unit_price,
                               'status': 'Finished' if r.status == 'F' else 'Active', 'order_id': r.id})
        else:
            return None

        return result

