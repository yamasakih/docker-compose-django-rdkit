FROM kubor/alpine-rdkit:2018.09.1.0

ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD . /code/

RUN conda install -y ipython jupyter pillow psycopg2 scikit-learn matplotlib\
    tqdm
