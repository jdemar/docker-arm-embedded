FROM ubuntu:latest
MAINTAINER Justin DeMartino <jdemarti@gmail.com>
LABEL Description="Docker image for building arm-embedded projects"

# General dependencies
RUN apt-get update && apt-get install -y \
  git \
  cmake \
  make \
  automake \
  ninja-build \
  python-dev \
  software-properties-common \
  ccache

# arm-none-eabi custom ppa
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa && \
  apt-get update && \
  apt-get install -y gcc-arm-embedded
  
#protobuf
ADD https://github.com/google/protobuf/releases/download/v3.1.0/protoc-3.1.0-linux-x86_64.zip protoc-3.1.0-linux-x86_64.zip
RUN unzip protoc-3.1.0-linux-x86_64.zip
RUN mv protoc-3.1.0-linux-x86_64/bin/protoc /usr/local/bin/
RUN rm -rf protoc-3.1.0-linux-x86_64.zip protoc-3.1.0-linux-x86_64
  
# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt
