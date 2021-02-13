# Build a image that will be used as REST API using Dockerfile inside folder ./rest_api
docker build -t rest_api:0.1 ./rest_api/

# Build a image that will be used for image resizing using Dockerfile inside folder ./image_resizing
docker build -t image_resizing:0.1 ./image_resizing/

# Run rest_api container
docker run --rm -it -v ${PWD}/stage/:/stage --name image_resizing_rest_api -p 5000:5000 -p 5672:5672 -p 15672:15672 rest_api:0.1

# Run container using image library convert to resize image
# docker run --rm -v ${PWD}/stage/:/stage image_resizing:0.1 convert -resize 365X365! ./stage/input_image.png ./stage/output_image.png
docker run --rm -it -v ${PWD}/stage/:/stage --name image_resizing_consumer1 --link image_resizing_rest_api image_resizing:0.1 

