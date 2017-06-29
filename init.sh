#!/bin/bash
#
# create hosts volumes - build system image
#

mkdir -p {localdata/{db,vault},autodeploy/bundles}
docker build -t docdokuplm:payara back/payara

