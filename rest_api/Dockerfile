# Using rabbitmq as base image
FROM rabbitmq:latest

# My contact
MAINTAINER Rodrigo Guarischi <rodrigoguarischi@gmail.com>

# Install python3, flask to use as REST API and pika for RabbitMQ queue management
RUN apt-get update \
    && apt-get install -y python3 python3-pip \
    && pip3 install --upgrade pip \
    && pip3 install flask pika

# Set /app as working dir and copy python scripts to it
WORKDIR /app
COPY . /app

# Flask uses port 5000 during runtime
EXPOSE 5000

# RabbitMQ uses ports 5672 and 15672
EXPOSE 5672
EXPOSE 15672

# Call initialization script which launches rest API and RabbitMQ 
ENTRYPOINT ["/bin/bash","/app/initiate_rest_container.sh"]
