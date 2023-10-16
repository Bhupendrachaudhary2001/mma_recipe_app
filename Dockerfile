#steps for docker to build our image
#python is the name of the docker image that lies on dockerhub
#3.9-alpine3.13 is the name of the tag that we are using
FROM python:3.9-alpine3.13

LABEL maintainer="bhupenra.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000
#create new virtual env
#full path of pip and upgrade pip#
#install requirements.txt inside virtual env
#remove tmp to ligten the docker image
#add new user inside our docker image
RUN python -m venv /py && \  
    /py/bin/pip install --upgrade pip && \   
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \   
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="py/bin:$PATH"

USER django-user