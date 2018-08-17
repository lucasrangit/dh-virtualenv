FROM ubuntu:16.04
#FROM ubuntu:bionic
#FROM debian:stretch
 
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update; \
    apt-get install --no-install-recommends -y \
        build-essential \
        software-properties-common \
        devscripts \
        equivs
 
COPY debian/control /tmp/deps/debian/
WORKDIR /tmp/deps
RUN apt-get update && \
    mk-build-deps --install --remove --tool 'apt-get --no-install-recommends -y --verbose-versions' debian/control && \
    dpkg-checkbuilddeps
 
WORKDIR /tmp/build
COPY ./ ./
RUN dpkg-buildpackage -us -uc -b && mkdir -p output && cp -pl ../* output/ || true

