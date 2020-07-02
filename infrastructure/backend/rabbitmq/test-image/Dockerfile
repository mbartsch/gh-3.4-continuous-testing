FROM python

ENV RABBIT_HOST="localhost"

RUN pip install pika

COPY test_connection.py /test_connection.py

ENTRYPOINT [ "python", "/test_connection.py" ]