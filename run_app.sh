# Build a image that will be used for image resizing using Dockerfile inside folder ./image_resizing
docker build -t image_resizing:0.1 ./image_resizing/

# Build a image that will be used as REST API using Dockerfile inside folder ./rest_api
docker build -t rest_api:0.1 ./rest_api/

# Run rest_api container
docker run --rm -it -p 5000:5000 -v ${PWD}/stage/:/stage rest_api:0.1


# Run container using image library convert to resize image
docker run --rm -v ${PWD}/stage/:/stage image_resizing:0.1 convert -resize 365X365! ./stage/input_image.png ./stage/output_image.png

# docker run --rm -it -p 5000:5000 -v ${PWD}/stage/:/stage alpine:latest
# 
# # Run docker 
# docker run --rm -it -p 5000:5000 -v ${PWD}/../stage/:/stage alpine:latest

