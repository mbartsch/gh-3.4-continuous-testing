FROM jenkins/jnlp-slave:4.3-4-alpine

USER root
RUN apk add --no-cache \
    python3 \
    py3-pip \
    docker \
    terraform \
    curl

# Install kubectl
RUN curl -o /usr/local/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install helm 3
RUN curl -o helm.tar.gz https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz \
    && tar -xvzf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -rf helm.tar.gz \
    && rm -rf linux-amd64

# Install awscli
RUN pip3 install awscli

USER jenkins

ENTRYPOINT ["jenkins-slave"]