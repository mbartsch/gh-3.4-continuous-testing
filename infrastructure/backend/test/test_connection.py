import pika
import os

host = os.environ['RABBIT_HOST']

try:
    connection = pika.BlockingConnection(pika.ConnectionParameters(host))
    channel = connection.channel()
    connection.close()
    print("Connection successful")
except:
    print("Cannot connect to Rabbit Server")
    exit(1)