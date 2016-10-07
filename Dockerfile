FROM ubuntu:latest
MAINTAINER Justin DeMartino <jdemarti@gmail.com>
LABEL Description="Docker image for building arm-embedded projects"

#protobuf
ENV PROTOBUF_VERSION="3.0.0"
ENV PROTOBUF_ZIP=protoc-${PROTOBUF_VERSION}-linux-x86_64.zip
ENV PROTOBUF_URL=https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/${PROTOBUF_ZIP}
ADD ${PROTOBUF_URL} ${PROTOBUF_ZIP}
RUN unzip ${PROTOBUF_ZIP} 'bin/*' -d /usr
    
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
  
# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt
