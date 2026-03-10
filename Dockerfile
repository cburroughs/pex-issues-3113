FROM ubuntu:24.04

RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt upgrade --yes && \
  DEBIAN_FRONTEND=noninteractive apt install --yes \
    build-essential \
    curl \
    file \
    git \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    make \
    tk-dev \
    xz-utils \
    zlib1g-dev

ENV PREFIX="/opt/python" BUILDDIR="/opt/python-build" PYTHONHASHSEED="0" SOURCE_DATE_EPOCH="315532800"
COPY build-pythons.sh ./
RUN chmod +x build-pythons.sh
RUN curl -fL https://github.com/pex-tool/pex/releases/download/v2.90.3/pex-linux-x86_64 -o /usr/local/bin/pex && \
  chmod +x /usr/local/bin/pex
RUN ./build-pythons.sh

COPY install-python.sh examine-pythons.sh reproduce.sh ./
RUN chmod +x install-python.sh examine-pythons.sh reproduce.sh

