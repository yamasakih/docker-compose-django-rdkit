# docker-compose-django-rdkit
Docker-compose to use compound database easily.

For an explanation of Japanese please see this article.  
(日本語の説明はこちらの記事をご覧ください)
[Django + RDKit database cartridge のDocker-composeで化合物データベースを作った話](https://qiita.com/yamasakih/items/58b3ef5eae6bfcd7fcf5)


## Docker image
### db
PostgreSQL with [RDKit database cartridge](http://www.rdkit.org/docs/Cartridge.html) for compound database

### web
[Django](https://www.djangoproject.com/) with [django-rdkit](https://github.com/rdkit/django-rdkit) for creating database and using database with Python

- PostsgreSQL (version 9.5)
- RDKit database cartridge (latest)
- Python (version 3.6.0)
   - Django (version 1.11.7)
   - django-rdkit (version 0.0.5)
   - psycopg2 (2.7.3.2)
   - Pillow (4.3.0)
   - RDKit (2017.03.1)
 

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
Building web
Step 1/9 : FROM kubor/alpine-rdkit
 ---> e204cd64867b
Step 2/9 : RUN apk add --no-cache git
 ---> Using cache
 ---> 2a4dd71a32de
Step 3/9 : ENV PYTHONUNBUFFERED 1
 ---> Using cache
 ---> 94d37711a020
Step 4/9 : RUN mkdir /code
 ---> Using cache
 ---> 29eba93d19e3
Step 5/9 : WORKDIR /code
 ---> Using cache
 ---> 2c39f3a58382
Step 6/9 : ADD requirements.txt /code/
 ---> Using cache
 ---> b78f5f28252e
Step 7/9 : RUN pip install -r requirements.txt
 ---> Using cache
 ---> e9e280e6de32
Step 8/9 : RUN pip install git+https://github.com/rdkit/django-rdkit.git
 ---> Using cache
 ---> 3aba85854ed2
Step 9/9 : ADD . /code/
 ---> 63843c8a3ab1
Successfully built 63843c8a3ab1
Successfully tagged dockercomposedjangordkit_web:latest
WARNING: Image for service web was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Creating dockercomposedjangordkit_db_1 ... 
Creating dockercomposedjangordkit_db_1 ... done
Creating dockercomposedjangordkit_web_1 ... 
Creating dockercomposedjangordkit_web_1 ... done
```

Please access `http://0.0.0.0:8000` or `http://localhost:8000`, 
Then you can see `It worked!`

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


For more information, see branch [add-mol-table](https://github.com/yamasakih/docker-compose-django-rdkit/tree/feature/add-mol-table) or django-rdkit's [tutorial.rst](https://github.com/rdkit/django-rdkit/blob/master/docs/tutorial.rst).
