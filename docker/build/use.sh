#!/bin/bash
#
# Place this Dockerfile at the repository root so it has the correct build context.

ROOT=$(dirname $0)/../..
THIS=${ROOT}/docker/build

cp ${THIS}/Dockerfile ${ROOT}/Dockerfile
