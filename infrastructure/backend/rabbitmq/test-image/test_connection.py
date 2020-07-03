import pika
import os

host = os.environ['RABBIT_HOST']
user = os.environ['RABBIT_USER']
passwd = os.environ['RABBIT_PASS']

try:
    credentials = pika.PlainCredentials(user, passwd)
    connection = pika.BlockingConnection(pika.ConnectionParameters(host,credentials=credentials))
    channel = connection.channel()
    connection.close()
    print("Connection successful")
except:
    print("Cannot connect to Rabbit Server")
    exit(1)
