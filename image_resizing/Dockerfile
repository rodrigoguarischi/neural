# Using alpine as base image due to small size
FROM alpine:latest

# My contact
MAINTAINER Rodrigo Guarischi <rodrigoguarischi@gmail.com>

# Install imagemagic package on Alpine used for image resizing
RUN apk update \
    && apk add imagemagick python3 py-pip \
    && pip3 install --upgrade pip \ 
    && pip3 install pika

# Set /app as working dir and copy python scripts to it
WORKDIR /app
COPY . /app

# Call main.py script 
ENTRYPOINT ["python3", "/app/image_resizing_consumer.py"]
