#!/usr/bin/env python
import os
import urllib.request
import pika
from app import app
from flask import Flask, request, redirect, jsonify
from werkzeug.utils import secure_filename

# File extesion accepted as valid for API
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])

# Port used to run Flask API
PORT = 5000;

# Function to check if provided file extesion is valid
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# Define Flask API route for POST. /file-upload will be the endpoint
@app.route('/file-upload', methods=['POST'])
def upload_file():

    # Check if the post request has the file part, return status code 400 if NOT
    if 'file' not in request.files:
        resp = jsonify({'message' : 'No file part in the request'})
        resp.status_code = 400
        return resp
    file = request.files['file']
    if file.filename == '':
        resp = jsonify({'message' : 'No file selected for uploading'})
        resp.status_code = 400
        return resp
    
    # If provided file is valid, save it to /stage folder and publish a message on the queue. 
    # Return code 201 if success
    if file and allowed_file(file.filename):

        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

        # Open connection and publish a message with filename on the queue
        # RabbitMQ server is on this container and is named image_queue
        connection = pika.BlockingConnection(
            pika.ConnectionParameters(host='localhost'))
        channel = connection.channel()
        channel.queue_declare(queue='image_queue')
        channel.basic_publish(exchange='', routing_key='image_queue', body=filename)
        connection.close()

        resp = jsonify({'message' : 'File successfully uploaded'})
        resp.status_code = 201
        return resp
    else:
        resp = jsonify({'message' : 'Allowed file types are png, jpg, jpeg, gif'})
        resp.status_code = 400
        return resp

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=PORT)
