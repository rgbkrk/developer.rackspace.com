#!/bin/bash
#
# Assemble the site into a working directory for Jekyll to use.

set -e

export WORK_DIR=/usr/src/_work
export TARGET_DIR=/usr/src/_site
export CONFIG=/usr/src/config/_config.yml

# Create the working directory.
mkdir -p ${WORK_DIR}

# Copy the Jekyll source into the work directory.
rsync -Ca /usr/src/site_source/ ${WORK_DIR}/

# Use Sphinx to build the API docs into a subdirectory of the work directory.
cd /usr/src/docs
sphinx-build . ${WORK_DIR}/docs
