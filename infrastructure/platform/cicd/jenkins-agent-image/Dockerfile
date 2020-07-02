FROM jenkins/jnlp-slave:4.3-4-alpine

ENV TERRAFORM_VERSION 0.12.28

USER root
RUN apk add --no-cache \
    python3 \
    py3-pip \
    docker \
    go \
    curl

# Install terraform
RUN cd /usr/local/bin && \
      curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
      unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
      rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

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

ENTRYPOINT ["jenkins-slave"]
