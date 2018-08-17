#!/usr/bin/env bash
set -o errexit
set -o xtrace

tag="$(basename $PWD | sed 's/_/-/g'):$(git rev-parse --short HEAD)"
pkgname="$(dh_listpackages)"

docker build --tag $tag .

mkdir -p output 
docker run --rm $tag tar -C output -c . | tar -C output -xv
dpkg-deb -I output/${pkgname}*.deb

