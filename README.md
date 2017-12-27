# docker-compose-django-rdkit
Docker-compose to use compound database easily.

For an explanation of Japanese please see this article.  
(日本語の説明はこちらの記事をご覧ください)  
[Django + RDKit database cartridge のDocker-composeで化合物データベースを作った話](https://qiita.com/yamasakih/items/58b3ef5eae6bfcd7fcf5)


## Docker image
### db
PostgreSQL with [RDKit database cartridge](http://www.rdkit.org/docs/Cartridge.html) for compound database

- PostsgreSQL (version 9.5)
- RDKit database cartridge (latest)

### web
[Django](https://www.djangoproject.com/) with [django-rdkit](https://github.com/rdkit/django-rdkit) for creating database and using database with Python

- Python (version 3.6.0)
   - Django (version 1.11.7)
   - django-rdkit (version 0.0.5)
   - psycopg2 (version 2.7.3.2)
   - Pillow (version 4.3.0)
   - RDKit (version 2017.03.1)
 

## How to use

### 1. git clone
```
git clone https://github.com/yamasakih/docker-compose-django-rdkit
cd docker-compose-django-rdkit
```

### 2. docker-compose up
```
docker-compose up -d
```

Just to do this.

```
> $ docker-compose up -d
Creating network "dockercomposedjangordkit_default" with the default driver
Creating volume "dockercomposedjangordkit_dbdata" with default driver
Building web
Step 1/9 : FROM kubor/alpine-rdkit
 ---> e204cd64867b
Step 2/9 : RUN apk add --no-cache git
 ---> Using cache
 ---> 6f0e09b5f69e
Step 3/9 : ENV PYTHONUNBUFFERED 1
 ---> Running in 982f015c0877
 ---> 58d9165cab2a
Removing intermediate container 982f015c0877
Step 4/9 : RUN mkdir /code
 ---> Running in 7b035348c449
 ---> 708259c183bb
Removing intermediate container 7b035348c449
Step 5/9 : WORKDIR /code
 ---> 3b5c539129fa
Removing intermediate container 480ea5c995f3
Step 6/9 : ADD requirements.txt /code/
 ---> 077e3641fbc3
Step 7/9 : RUN pip install -r requirements.txt
 ---> Running in 561f24e020db
Collecting Django==1.11.7 (from -r requirements.txt (line 1))
  Downloading Django-1.11.7-py2.py3-none-any.whl (6.9MB)
Collecting psycopg2==2.7.3.2 (from -r requirements.txt (line 2))
  Downloading psycopg2-2.7.3.2-cp36-cp36m-manylinux1_x86_64.whl (2.7MB)
Collecting pillow==4.3.0 (from -r requirements.txt (line 3))
  Downloading Pillow-4.3.0-cp36-cp36m-manylinux1_x86_64.whl (5.8MB)
Collecting pytz (from Django==1.11.7->-r requirements.txt (line 1))
  Downloading pytz-2017.3-py2.py3-none-any.whl (511kB)
Collecting olefile (from pillow==4.3.0->-r requirements.txt (line 3))
  Downloading olefile-0.44.zip (74kB)
Building wheels for collected packages: olefile
  Running setup.py bdist_wheel for olefile: started
  Running setup.py bdist_wheel for olefile: finished with status 'done'
  Stored in directory: /root/.cache/pip/wheels/20/58/49/cc7bd00345397059149a10b0259ef38b867935ea2ecff99a9b
Successfully built olefile
Installing collected packages: pytz, Django, psycopg2, olefile, pillow
Successfully installed Django-1.11.7 olefile-0.44 pillow-4.3.0 psycopg2-2.7.3.2 pytz-2017.3
 ---> 2cb6ac1ae78d
Removing intermediate container 561f24e020db
Step 8/9 : RUN pip install git+https://github.com/rdkit/django-rdkit.git
 ---> Running in 04157c63862e
Collecting git+https://github.com/rdkit/django-rdkit.git
  Cloning https://github.com/rdkit/django-rdkit.git to /tmp/pip-tju8uk22-build
Installing collected packages: django-rdkit
  Running setup.py install for django-rdkit: started
    Running setup.py install for django-rdkit: finished with status 'done'
Successfully installed django-rdkit-0.0.5
 ---> 75c0a26d8fbe
Removing intermediate container 04157c63862e
Step 9/9 : ADD . /code/
 ---> 7dc60211c63c
Successfully built 7dc60211c63c
Successfully tagged dockercomposedjangordkit_web:latest
WARNING: Image for service web was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Creating dockercomposedjangordkit_db_1 ... 
Creating dockercomposedjangordkit_db_1 ... done
Creating dockercomposedjangordkit_web_1 ... 
Creating dockercomposedjangordkit_web_1 ... done
```

Please access `http://0.0.0.0:8000` or `http://localhost:8000`, then you can see `It worked!`

If you can't, please restart docker-compose.

```
> $ docker-compose stop
Stopping dockercomposedjangordkit_web_1 ... done
Stopping dockercomposedjangordkit_db_1  ... done

> $ docker-compose restart
Restarting dockercomposedjangordkit_web_1 ... done
Restarting dockercomposedjangordkit_db_1  ... done
```

### 3. Initialize the database
First, initialize the database by doing `migrate`.  
You can use Django's manage.py command by simply adding `docker-compose run web` at the beginning.

```
> $ docker-compose run web ./manage.py migrate
Starting dockercomposedjangordkit_db_1 ... done
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, django_rdkit, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying django_rdkit.0001_setup... OK
  Applying sessions.0001_initial... OK```
```

### 4. Delete mount volume
This Docker-compose uses named volume.  
If it becomes unnecessary, delete it with the following command.

```
> $ docker volume list
DRIVER              VOLUME NAME
local               dockercomposedjangordkit_dbdata
```

```
> $ docker volume rm dockercomposedjangordkit_dbdata 
dockercomposedjangordkit_dbdata
```

```
> $ docker volume list                        
DRIVER              VOLUME NAME
```

For more information, see branch [add-mol-table](https://github.com/yamasakih/docker-compose-django-rdkit/tree/feature/add-mol-table) or django-rdkit's [tutorial.rst](https://github.com/rdkit/django-rdkit/blob/master/docs/tutorial.rst).
