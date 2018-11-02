FROM java:8-jre

LABEL maintainer="Stephen Wolfe <stephenwolfe1@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV KAFKA_VERSION="1.1.1"
ENV SCALA_VERSION="2.12"

RUN apt-get update && apt-get install -y apt-transport-https

RUN ( apt-get update && \
      apt-get install -y --no-install-recommends \
      python-pip \
      python-dev \
      build-essential && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* )

RUN ( pip install pip --upgrade && \
      pip install --upgrade setuptools && \
      pip install kafka-tools )

RUN ( wget -q http://apache.mirrors.spacedump.net/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O /tmp/kafka.tgz && \
      tar xfz /tmp/kafka.tgz -C /opt && \
      mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka && \
      cd /opt/kafka/bin/ && \
      rm /tmp/kafka.tgz )

ENV PATH="/opt/kafka/bin:${PATH}"
