FROM ubuntu:latest
MAINTAINER Justin DeMartino <jdemarti@gmail.com>
LABEL Description="Docker image for building arm-embedded projects"
    
# General dependencies
RUN apt-get update && apt-get install -y \
  git \
  cmake \
  make \
  automake \
  autoconf \
  libtool \
  g++ \
  ninja-build \
  python-dev \
  software-properties-common \
  ccache \
  unzip \
  python-setuptools \
  python-dev \
  curl \
  srecord

# Easy Install
RUN easy_install gitchangelog

# arm-none-eabi custom ppa
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa && \
  apt-get update && \
  apt-get install -y gcc-arm-embedded
  
# protobuf
ENV PROTOBUF_VERSION="3.1.0"
ENV PROTOBUF_CPP=protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
ENV PROTOBUF_URL=https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/${PROTOBUF_CPP}
ADD ${PROTOBUF_URL} ${PROTOBUF_CPP}
RUN tar -zxf ${PROTOBUF_CPP} -C /tmp && \
    cd /tmp/protobuf-${PROTOBUF_VERSION} && \
    ./configure && \
    make && \
    make install && \
    ldconfig && \
    easy_install protobuf && \
    cd - && \
    rm -rf ${PROTOBUF_CPP} /tmp/protobuf-${PROTOBUF_VERSION}
  
# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt

RUN localedef -i en_US -f UTF-8 en_US.UTF-8
