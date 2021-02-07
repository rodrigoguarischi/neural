# Using alpine as base image due to small size
FROM alpine:latest

# My contact
MAINTAINER Rodrigo Guarischi <rodrigoguarischi@gmail.com>

# Install python3 and flask to use as REST API
RUN apk add --no-cache python3-dev py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install flask

# Set /app as working dir and copy python scripts to it
WORKDIR /app
COPY . /app

# Flask uses port 5000 during runtime
EXPOSE 5000

# Call main.py script 
ENTRYPOINT ["python3", "/app/main.py"]
