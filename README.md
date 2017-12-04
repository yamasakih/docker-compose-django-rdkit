# docker-compose-django-rdkit
Docker-compose to use compound database easily.

For an explanation of Japanese please see this article.  
日本語の説明はこちらの記事をご覧ください  
[Django + RDKit database cartridge のDocker-composeで化合物データベースを作った話](https://qiita.com/yamasakih/items/58b3ef5eae6bfcd7fcf5)


## Docker image
### db
PostgreSQL + [RDKit database cartridge](http://www.rdkit.org/docs/Cartridge.html) for compound database

### web
django + [django-rdkit](https://github.com/rdkit/django-rdkit) for creating database and using database with Python

## How to use

### 1.git clone
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
> $ docker-compose up
Starting dockercomposedjangordkit_db_1 ... 
Starting dockercomposedjangordkit_db_1 ... done
Starting dockercomposedjangordkit_web_1 ... 
Starting dockercomposedjangordkit_web_1 ... done
Attaching to dockercomposedjangordkit_db_1, dockercomposedjangordkit_web_1
db_1   | LOG:  database system was interrupted; last known up at 2017-11-08 00:05:40 UTC
db_1   | LOG:  database system was not properly shut down; automatic recovery in progress
db_1   | LOG:  invalid record length at 0/18841E0
db_1   | LOG:  redo is not required
db_1   | LOG:  MultiXact member wraparound protections are now enabled
db_1   | LOG:  database system is ready to accept connections
db_1   | LOG:  autovacuum launcher started
web_1  | Performing system checks...
web_1  | 
web_1  | System check identified no issues (0 silenced).
web_1  | December 04, 2017 - 01:27:34
web_1  | Django version 1.11.7, using settings 'package_root.settings'
web_1  | Starting development server at http://0.0.0.0:8000/
web_1  | Quit the server with CONTROL-C.
```

Please access `http://0.0.0.0:8000` or `http://localhost:8000`, 
Then you can see `It worked!`

If you can't, please restart docker-compose.

```
docker-compose stop
docker-compose restart
```
