## Installation

### REST API
Build a image that will be used as REST API using Dockerfile inside folder ./rest_api
```
docker build -t rest_api:0.1 ./rest_api/
```

### Image Resizing
Build a image that will be used for image resizing using Dockerfile inside folder ./image_resizing
```
docker build -t image_resizing:0.1 ./image_resizing/
```

## Running aplication

### Launching the Rest API container
The application needs one (and only one) rest api container running in order to receive requests.
This container will be named as 'image_resizing_rest_api', so other containers in the network can
find it and connect to it. 
```
docker run --rm -it -v ${PWD}/stage/:/stage --name image_resizing_rest_api -p 5000:5000 -p 5672:5672 -p 15672:15672 rest_api:0.1
```

### Image resizing container(s)
You can launch as many consumers as you want by launching multiple consumer containers using the following command
```
docker run --rm -it -v ${PWD}/stage/:/stage --link image_resizing_rest_api image_resizing:0.1
```
