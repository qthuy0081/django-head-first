FROM python:3.8.5-alpine

ENV PYTHONUNBUFFERED 1

ENV APP_HOME=/api

COPY ./requirements.txt $APP_HOME/requirements.txt

RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc postgresql-dev linux-headers musl-dev \
    libffi-dev jpeg-dev zlib-dev libwebp-dev 

RUN apk update && \
    apk upgrade -U && \
    apk add ca-certificates ffmpeg libwebp libwebp-tools && \
    rm -rf /var/cache/*
RUN pip install -r $APP_HOME/requirements.txt

WORKDIR $APP_HOME

COPY ./ $APP_HOME

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

