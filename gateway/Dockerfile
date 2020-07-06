FROM python:3.7-slim-stretch as base

RUN apt-get update && \
    apt-get install --yes curl netcat

RUN pip3 install --upgrade pip
RUN pip3 install virtualenv

RUN virtualenv -p python3 /appenv

ENV PATH=/appenv/bin:$PATH

RUN groupadd -r nameko && useradd -r -g nameko nameko

RUN mkdir /var/nameko/ && chown -R nameko:nameko /var/nameko/

# ------------------------------------------------------------------------

FROM base as builder

RUN apt-get update && \
    apt-get install --yes build-essential autoconf libtool pkg-config \
    libgflags-dev libgtest-dev clang libc++-dev automake git libpq-dev

RUN pip install auditwheel

COPY . /application

ENV PIP_WHEEL_DIR=/application/wheelhouse
ENV PIP_FIND_LINKS=/application/wheelhouse

# ------------------------------------------------------------------------

FROM builder AS wheels

COPY . /application

RUN cd /application && pip wheel .

# ------------------------------------------------------------------------

FROM base AS install

COPY --from=wheels /application/wheelhouse /wheelhouse

RUN pip install --no-index -f /wheelhouse nameko_examples_gateway

# ------------------------------------------------------------------------

FROM base

COPY --from=install /appenv /appenv

COPY config.yml /var/nameko/config.yml
COPY run.sh /var/nameko/run.sh

RUN chmod +x /var/nameko/run.sh

USER nameko

WORKDIR /var/nameko/

EXPOSE 8000

CMD /var/nameko/run.sh;
