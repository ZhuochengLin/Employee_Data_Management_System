# README

This is the final project for my course, CS5200 Database Management. In this project, 
an employee information management system is built using Django. It supports typical CRUD
operations and offers comprehensive constraint check.

Tech Stack:
* MySQL
* Python
* HTML, CSS, Bootstrap
* Django

![image.png](/redirect/s3?bucket=uploads&prefix=paste%2Fk9sw8fxtvq349t%2Feb6be903b1f63a00ea2f2b2e761bc8cdcf31f28785e03f1ea35c50e122c45c75%2Fimage.png)

## How to rebuild the project
1. Set up MySQL database
    * Import the MySQL dump file, ```./lin_final_project.sql```
    * Make sure the database name is ```cs5200_employee```, which contains 18 tables.
    * Make sure there are stored procedures.
    * Make sure there are 3 triggers.
    * Note: you can check these in the database info section.

2. Set up virtual environment, Anaconda is recommended. Python version is ```3.7.9```.

    ```
    conda create -n <env name> python=3.7
    ```

3. Set up Django project
    * Go to the root directory ```django_project/```.
    * Set up database connection info in the ```my.cnf``` file
        * You need to provide your MySQL username and password
    * Install required packages, in your virtual environment,

        ```
        pip install -r requirements.txt
        ```
    * Remember to set the correct Python interpreter, the one in your virtual environment.
    * Under the root directory, there should be a ```manage.py``` file, then run

        ```
        python manage.py makemigrations
        python manage.py migrate
        python manage.py runserver
        ```
    * Now go to ```http://127.0.0.1:8000/``` in your browser (check the exact url in your terminal).
    * The project should be running.
    * To login the system, you can use two existing users:
        1. username: ```admin_access```, password: ```cs5200admin```, access level: ```admin```
        2. username: ```guest_access```, password: ```cs5200guest```, access level: ```guest```
        
        An admin user can grant ```admin``` access to a guest user. Newly registered users are guest users by default.
    * In case you need, the Django superuser is
        * username: ```admin```, password: ```cs5200admin```
        
