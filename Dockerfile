FROM ubuntu:18:04

ENV DEBIAN_FRONTEND=noninteractive \
   PATH=${PATH}:/kafka/bin \ 
   KAFKA_VERSION=2.6.0 \
   SCALA_VERSION=2.13

RUN apt-get update \
   && apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        jq \
        git \
        openjdk \
        software-properties-common \
        tar \
        vim \
        wget

RUN groupadd kafka \
   && useradd kafka -m -G kafka \
   && echo "kafka" | passwd --stdin kafka

RUN mkdir /kafka \
   && chown kafka:kafka /kafka

RUN wget "https://www.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz" -P /kafka \
   tar -xvzf /kafka/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz

USER kafka

CMD "/kafka/bin/kafka-server-start.sh" "/kafka/config/server.properties"