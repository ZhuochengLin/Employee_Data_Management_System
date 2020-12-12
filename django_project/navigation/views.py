from django.contrib import messages
from django.contrib.auth.models import User
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect, HttpResponse
from django.contrib.auth import authenticate, login, logout
from django.urls import reverse

from navigation.forms import UserRegisterForm, SystemUserForm
from navigation.models import SystemUser


def user_register(request):

    registered = False

    user = UserRegisterForm()
    system_user = SystemUserForm()

    if request.method == 'POST':
        user = UserRegisterForm(request.POST)
        if user.is_valid():
            # save the user, then hash the password, save again
            user = user.save()
            user.set_password(user.password)
            user.save()

            # one to one field
            system_user = SystemUserForm({'user': user, 'access_level': request.POST['access_level']})
            system_user.save()

            registered = True

    return render(request, 'navigation/register.html',
                  {'user': user, 'system_user': system_user, 'registered': registered})


@login_required
def user_logout(request):
    print(request.user)
    logout(request)
    print("yes")
    return HttpResponseRedirect(reverse('index'))


def user_login(request):

    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        user = authenticate(username=username, password=password)

        if user:
            if user.is_active:
                login(request, user)
                return HttpResponseRedirect(reverse('index'))
            else:
                return HttpResponse('ACCOUNT NOT ACTIVE')
        else:
            messages.error(request, "Invalid username or password.")

    user = UserRegisterForm()

    return render(request, 'navigation/login.html', {'user': user})


def index(request):
    return render(request, 'navigation/index.html', {})


def has_admin_access(request):
    user = request.user
    if user.username != 'admin':
        user = User.objects.filter(username=user)[0]
        system_user = SystemUser.objects.filter(user_id=user.id)[0]
        access_level = system_user.access_level
        if access_level == 'G':
            return False
        else:
            return True
    return True


def guest_access(request):
    return render(request, 'navigation/guest_access.html')
