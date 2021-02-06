# Using alpine as base image due to small size
FROM alpine

# My contact
MAINTAINER Rodrigo Guarischi <rodrigoguarischi@gmail.com>

# Install imagemagic package on Alpine used for image resizing
RUN apk add imagemagick
