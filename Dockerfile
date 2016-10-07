FROM ubuntu:latest
MAINTAINER Justin DeMartino <jdemarti@gmail.com>
LABEL Description="Docker image for building arm-embedded projects"

# General dependencies
RUN apt-get update && apt-get install -y \
  git \
  subversion \
  cmake \
  make \
  automake \
  ninja-build \
  python-dev \
  software-properties-common \
  protobuf \
  ccache

# arm-none-eabi custom ppa
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa && \
  apt-get update && \
  apt-get install -y gcc-arm-embedded
  
# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt
