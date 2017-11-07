FROM python:2.7
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
RUN git clone https://github.com/rdkit/django-rdkit.git && python ./django-rdkit/setup.py install
ADD . /code/

