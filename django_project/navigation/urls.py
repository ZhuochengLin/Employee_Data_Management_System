from django.urls import path, include
from navigation import views

urlpatterns = [
    path('', views.index),
    path('login/', views.user_login, name='user-login'),
    path('logout/', views.user_logout, name='user-logout'),
    path('register/', views.user_register, name='user-register'),
    path('index/', views.index, name='index'),
    path('read/', include('read.urls')),
    path('create/', include('create.urls')),
    path('update/', include('update.urls')),
    path('delete/', include('delete.urls')),
    path('guest/', views.guest_access, name='guest')
]
