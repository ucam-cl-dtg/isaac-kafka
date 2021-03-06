FROM java:openjdk-8-jdk

ARG kafka_version=0.11.0.0
ARG scala_version=2.12

RUN apt-get update
RUN apt-get install -yy unzip wget curl jq coreutils

ENV KAFKA_VERSION=$kafka_version SCALA_VERSION=$scala_version

RUN wget -q "https://www-eu.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" -O "/tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" && \
   tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
   rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
   ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka



ENV KAFKA_HOME /opt/kafka
ENV PATH ${PATH}:${KAFKA_HOME}/bin

COPY run.sh /run.sh

CMD ["/run.sh"]
