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

ENV PREFIX="/opt/python" PYTHONHASHSEED="0" SOURCE_DATE_EPOCH="315532800"
COPY build-pythons.sh .
RUN ./build-pythons.sh

COPY examine-pythons.sh .

