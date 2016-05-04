# Riak S2
# VERSION 0.0.2
# @ntoggle 2016

FROM phusion/baseimage:0.9.18
MAINTAINER Johnny Everson j.everson@ntoggle.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get upgrade -y

RUN curl -s https://packagecloud.io/install/repositories/basho/riak/script.deb.sh | sudo bash
RUN curl -s https://packagecloud.io/install/repositories/basho/riak-cs/script.deb.sh | sudo bash
RUN curl -s https://packagecloud.io/install/repositories/basho/stanchion/script.deb.sh | sudo bash

RUN apt-get install riak stanchion riak-cs

ENV STANCHION_ENABLED true
ENV SEED_HOST 127.0.0.1
ENV RIAK_S2_CLUSTER_SIZE 1

ADD etc/riak/advanced.config /etc/riak/
ADD etc/riak/riak.conf /etc/riak/
ADD etc/riak-cs/riak-cs.conf /etc/riak-cs/
ADD etc/stanchion/stanchion.conf /etc/stanchion/

COPY bin/start-services.sh /etc/my_init.d/01-start-services.sh

EXPOSE 8080 8085

#RUN echo "WAIT_FOR_ERLANG=60" > /etc/default/riak

# Leverage the baseimage-docker init system
CMD ["/sbin/my_init", "--quiet"]
