FROM python:3.7-alpine

LABEL Image for a simple flask application

WORKDIR /docker-app

COPY . .

RUN ["pip3", "install", "pipenv"]

RUN ["pipenv", "install"]

CMD pipenv run python hello_world.py
