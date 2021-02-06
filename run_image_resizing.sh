# Build a image that will be used for image resizing
docker build -t image_resizing:0.1 ./

# Run container using image library convert to resize image
docker run --rm -v ${PWD}/test_images/:/work image_resizing:0.1 convert -resize 365X365! /work/input_image.png /work/output_image.png
