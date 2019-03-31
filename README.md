# docker-compose-lbdd
An enviroment for ligand-based drug discovery.

This repositry were forked form [yamasakih/docker-compose-django-rdkit](https://github.com/yamasakih/docker-compose-django-rdkit)
## Setup
```
git clone git@github.com:masahiro-mochizuki/docker-compose-lbdd.git
cd docker-compose-lbdd
docker-compose build
```

## How to use
### Launch Jupyter Notebook
```
docker-compose up default
```

After execution of the above command, the message below will be shown like this:

```
main_1  |     Copy/paste this URL into your browser when you connect for the first time,
main_1  |     to login with a token:
main_1  |         http://(c3a6946d1451 or 127.0.0.1):8888/
```

In this example, you can access jupyter via URL.
`http://127.0.0.1:8888/ .

An example code of accessing PostgresSQL from jupyter is `examples/db_example.ipynb`.

### Excecute a python code
you can execute a python code without PostgreSQL database:
```
docker-compose run default  python examples/mw_from_smiles.py CCC
```

## Services
### default
- Python (version 3.6.0)
   - RDKit (version 2018.09.1.0)
   - scikit-learn
   - lightGBM
   - chainer
   - optuna
   - PostgreSQL10
   - pandas
   - numpy
   - matplotlib
   - tqdm
   - ipython
   - Jupyter Notebook
### nvidia
The same package as the default is installed, but this service supports CUDA10.0.
