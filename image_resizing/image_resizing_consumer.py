#!/usr/bin/env python
import pika, sys, os
import subprocess

def main():
    # Stablish a connection to the Rabbit Queue
    credential = pika.PlainCredentials('rodrigo', 'rodrigo123')
    connection = pika.BlockingConnection(pika.ConnectionParameters(host='image_resizing_rest_api', credentials=credential))
    channel = connection.channel()
    channel.queue_declare(queue='image_queue')

    # Callback function is responsible for treating income messages and call 'convert' to resize images
    def callback(ch, method, properties, body):
        print("Starting resizing of image " + body.decode())
        image_resize = subprocess.run(['convert', "-resize", "365X365!", "/stage/" + body.decode(), "/stage/resized/" + body.decode()])
        print("Resizing of image " + body.decode() + " completed with return code ", image_resize.returncode)

    channel.basic_consume(queue='image_queue', on_message_callback=callback, auto_ack=True)

    # Message displayed when worker starts up
    print("Waiting for messages. To exit press CTRL+C...")
    
    # A never-ending loop that waits for data and runs callbacks whenever necessary
    channel.start_consuming()

# Catch KeyboardInterrupt during program shutdown
if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
