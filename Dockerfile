FROM kubor/alpine-rdkit
RUN apk add --no-cache git
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
RUN pip install git+https://github.com/rdkit/django-rdkit.git
ADD . /code/
