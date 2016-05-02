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
