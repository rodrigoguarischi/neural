#!/bin/bash

# The rest API container is responsible to 2 microservices: the API itself (in Flask) and
# also the rabbitmq-server, responsible for queue management. This script is responsible
# for launching these 2 services and dealing with some basic configuration
# 
# version 1.0
#

### PREAMBLE ###################################################################################### 

### FUNCTIONS #####################################################################################

rabbitmq_server_status() {

  `rabbitmqctl status > /dev/null 2>&1;`
  rabbitmq_status=$?;

  if [ ${rabbitmq_status} -eq '0' ]; then
    echo -ne "up"
  else
    echo -ne "down"
  fi
}

### DATA ANALYSIS #################################################################################

# Start rabbitmq-server and wait for it to be up
rabbitmq-server -detached;
while [ "$(rabbitmq_server_status)" != "up" ]; do 
  sleep 2;
done
echo -e "[`date`]\tRabbitMQ is up";

# Add rodrigo user to rabbitmq and restart the service
rabbitmqctl add_user rodrigo rodrigo123;
rabbitmqctl set_permissions -p / rodrigo ".*" ".*" ".*";
rabbitmqctl shutdown;
rabbitmq-server -detached;
while [ "$(rabbitmq_server_status)" != "up" ]; do
  sleep 2;
done
echo -e "[`date`]\tRabbitMQ is configured and up";

# Launch rest API
echo -e "[`date`]\tInitializing rest API";
python3 /app/rest_api.py
