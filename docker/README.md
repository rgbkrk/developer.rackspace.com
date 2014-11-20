# Dockerfiles

This directory contains the specifications for constructing [Docker](https://docker.com/whatisdocker/) containers for individual parts of the developer.rackspace.com infrastructure.

If you're developing something that will ultimately be deployed within one of these containers, call `script/dockbuild` with the directory name to rebuild an image that includes your changes. Right now, this only includes the build stack itself.

If you're writing content in `src/docs` or `src/site_source`, you can use the latest build from Dockerhub instead, which entry points like `script/preview` will do for you automatically.

## Contents

Each subdirectory provides the pieces necessary for a single container image, which include:

 1. A [Dockerfile](https://docs.docker.com/reference/builder/) for that container.
 2. `vars.sh`, a Bash script that exports two variables that control the build:
    * `CONTEXT` specifies the build context for the build process. The build context controls which files may by `ADD`ed to the container. This will generally be relative to `${ROOT}`, which is populated externally to be the root of this repository.
    * `TAG` will be used to name the resulting image. It should begin with `devsite/` so that the resulting image can be pushed to the correct organization on Dockerhub.
 3. Any other resources that are only useful to this container.
